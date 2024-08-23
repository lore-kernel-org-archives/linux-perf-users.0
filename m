Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D13185B59;
	Fri, 23 Aug 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416906; cv=none; b=N+ldWrc/uXC7VONxbfoaRc8KVuRw38lI1kxLaG3PTjqZH5l6iwV1d+WDZ8oKTcXtPYnrwdzk04gTLmIRySL2DutS8S7Bp1RVA4OlI+ldZdNGpoiBflNTrYOvcbYxVAofoJitlnFM1/LYVZaEjXLI3vOkCanrZOiOTAMe5B/huCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416906; c=relaxed/simple;
	bh=BEaYGjC5hSPTst1Zu5sZRe9Sk3mL4Z9ePTalnjJKUNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUVB63htVvyo0ZoqQzzdPWz4HkBtz0Jk5dwXn2+UIl+arXXIZPGlh8G5bWVw7q7HLDxCMu7zlGppIEjE9DpKkoCkzVlZ5efVQwPndQO/8BQy2DgO/dUnSakxtFZ/eGmBX1Fl63KQoAx36BXXpEJ/UW0r2yRYMOeKF63VK/he/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeJuHq6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeJuHq6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752E6C32786;
	Fri, 23 Aug 2024 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416906;
	bh=BEaYGjC5hSPTst1Zu5sZRe9Sk3mL4Z9ePTalnjJKUNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeJuHq6PmoKaO1+wZ4Y/rx5s/pM4C1ohVjy2iIfqD979aXD8bO4eT9SOvOVUnURAk
	 SANhd+x9Ey92dzIBsLQnfKDrA23jJ/0OsmpeZ4gqmjNizrT8gRZAtGbMhC6kje0ENK
	 rWJarF52LlaUGvnxy98JLp7bB11edh1ebUI0ZwLAqkgtyggfg9cbY5V0NQF7HQIK8u
	 XRedSPE0859PtIrGNiu7ipAOjEJM2Sm9BzTfqxo583Z3nI++4T0bnVjv90wyGapklK
	 w3tNrqeSKRWDN8oOuAuBFlEcP7gvCJpZfyvWBSAXLqQSKF3gksFoAndeCcMulnAYLY
	 /lLKfqt8v6AFA==
Date: Fri, 23 Aug 2024 09:41:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] perf trace: Pretty print struct data
Message-ID: <ZsiDhSPs4XYX4VP9@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-7-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815013626.935097-7-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:22AM +0800, Howard Chu wrote:
> Use btf_dump API to pretty print augmented struct pointer.
> 
> set compact = true and skip_names = true, so that no newline character
> and argument name are printed.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 51 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 4bde40f91531..e7421128f589 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1006,6 +1006,55 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
>  	return 0;
>  }
>  
> +#define DUMPSIZ 1024
> +
> +static void btf_dump_snprintf(void *ctx, const char *fmt, va_list args)
> +{
> +	char *str = ctx, new[DUMPSIZ];
> +
> +	vscnprintf(new, DUMPSIZ, fmt, args);
> +
> +	if (strlen(str) + strlen(new) < DUMPSIZ)
> +		strncat(str, new, DUMPSIZ - strlen(str) - 1);
> +}
> +
> +static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg, int type_id)
> +{
> +	char str[DUMPSIZ];
> +	int dump_size;
> +	int consumed;


Take a look at this simplification:

struct trace_btf_dump_snprintf_ctx {
        char   *bf;
        size_t printed, size;
};

static void trace__btf_dump_snprintf(void *vctx, const char *fmt, va_list args)
{
        struct trace_btf_dump_snprintf_ctx *ctx = vctx;

        ctx->printed += vscnprintf(ctx->bf + ctx->printed, ctx->size - ctx->printed, fmt, args);
}

static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg)
{
        struct trace_btf_dump_snprintf_ctx ctx = {
                .bf   = bf,
                .size = size,
        };


I.e. use a context to pass the original buffer and size received by
btf_struct_scnprintf, and go on printing on it instead of using two
extra buffers in btf_struct_scnprintf() and trace__btf_dump_snprintf()
doing more truncation than needed with those series of strlen() calls
before using strncat in trace__btf_dump_snprintf().

Also type id can be obtained from arg->fmt->type_id, so remove that
extra argument, that way we can go on thinking about having an unified
function signature for all btf types (enum and struct at this point in
the series).

> +	struct btf_dump *btf_dump;
> +	struct augmented_arg *augmented_arg = arg->augmented.args;
> +
> +	LIBBPF_OPTS(btf_dump_opts, dump_opts);
> +	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> +
> +	if (arg == NULL || arg->augmented.args == NULL)
> +		return 0;
> +
> +	memset(str, 0, sizeof(str));

We don't need this memset then

> +
> +	dump_data_opts.compact     = true;
> +	dump_data_opts.skip_names  = true;
> +
> +	btf_dump = btf_dump__new(btf, btf_dump_snprintf, str, &dump_opts);
> +	if (btf_dump == NULL)
> +		return 0;

I wonder if we could stop doing this new + free for the btf_dump object
at each btf_struct_scnprintf() call, but I'll leave this for later.

> +	/* pretty print the struct data here */
> +	dump_size = btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts);
> +	if (dump_size == 0)
> +		return 0;
> +
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> +	arg->augmented.size -= consumed;
> +
> +	btf_dump__free(btf_dump);
> +
> +	return scnprintf(bf, size, "%s", str);

Here we return ctx.printed.

I'll get what I have and leave it in that tmp.perf_trace_btf branch.

One other thing I think that the skel patch should come before these,
so that at this point in the series I could _test_ struct printing.

- Arnaldo

> +}
> +
>  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
>  				   size_t size, int val, struct syscall_arg *arg, char *type)
>  {
> @@ -1023,6 +1072,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
>  
>  	if (btf_is_enum(arg_fmt->type))
>  		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
> +	else if (btf_is_struct(arg_fmt->type))
> +		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg, arg_fmt->type_id);
>  
>  	return 0;
>  }
> -- 
> 2.45.2
