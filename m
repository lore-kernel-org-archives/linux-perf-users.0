Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB48BE8;
	Sat, 17 Aug 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911857; cv=none; b=H0Bxt83Hs3H9tEx6FfEwKdUqbtpW8cEuBllYG2eqfhwXchFg+3xQXO30Zbx30PKX577HHRGTDtp42iLL0Nhp0A9aSLmVj7KLpReHdCaJ89IJlTk7lQV+77u7NqwNAk+XNQgmDfxmhNNXIQgxviB40i+fu7z+KhLn6iS6xh7ZNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911857; c=relaxed/simple;
	bh=a8dBuNVNq92Ukh754Ghth06R/U4P6kBCoB3toZgEH8M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZnQ6y+lxQxxAPWMFgL2YxYsP+e6vgtiAiNk6YUfNuLQ9fTHpvplUM4PMlMGfpTH5VJVFqltez1renIvlLhgZedVSD+qzD+U2FGiJHMuJcDdO3en0zL9goQ5DbrVGapUdCjlSOf21nrJ87gr/uKeKx7fFwZLQZYNBrEC4WzbZ9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br1mcI9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br1mcI9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083D4C116B1;
	Sat, 17 Aug 2024 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723911856;
	bh=a8dBuNVNq92Ukh754Ghth06R/U4P6kBCoB3toZgEH8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Br1mcI9lYUiQLxjtthDaIZdes03XTL9RPi1ubI2ZYBaod0U1IhJSz2C1p35ofKjez
	 Lksi0Rf6qhAxgvmsR7z7PjuofJJ6KhSUF7WNQrCNTTKLtsKsEvCUQJjpMtk7JsHypm
	 O2KmH6Gw+Ogsi/iY43QzDGh26npFw1H3HUWaATKKJ+gir6qiKth8LnIZZPBN1EwGEK
	 /uPUOKw0HSl2+hFDJBz4F3kVtUhg543H205SXWKth//XCf0sBmRZG26QsFa/OX2Mh/
	 11eQTUaWr7WK5AeW84IgpZv7Jo/8K16SVhxbyJqMI4aOzgUDw8P0t2HFQib1qEkl5s
	 la0OolN6gFhHw==
Date: Sun, 18 Aug 2024 01:24:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH 1/9] perf dwarf-aux: Check allowed location expressions
 when collecting variables
Message-Id: <20240818012411.a00eb93e5b8f9cf45e2f513b@kernel.org>
In-Reply-To: <20240816235840.2754937-2-namhyung@kernel.org>
References: <20240816235840.2754937-1-namhyung@kernel.org>
	<20240816235840.2754937-2-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 16:58:31 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> It missed to call check_allowed_ops() in __die_collect_vars_cb() so it
> can take variables with complex location expression incorrectly.
> 
> For example, I found some variable has this expression.
> 
>     015d8df8 ffffffff81aacfb3 (base address)
>     015d8e01 v000000000000004 v000000000000000 views at 015d8df2 for:
>              ffffffff81aacfb3 ffffffff81aacfd2 (DW_OP_fbreg: -176; DW_OP_deref;
> 						DW_OP_plus_uconst: 332; DW_OP_deref_size: 4;
> 						DW_OP_lit1; DW_OP_shra; DW_OP_const1u: 64;
> 						DW_OP_minus; DW_OP_stack_value)
>     015d8e14 v000000000000000 v000000000000000 views at 015d8df4 for:
>              ffffffff81aacfd2 ffffffff81aacfd7 (DW_OP_reg3 (rbx))
>     015d8e19 v000000000000000 v000000000000000 views at 015d8df6 for:
>              ffffffff81aacfd7 ffffffff81aad020 (DW_OP_fbreg: -176; DW_OP_deref;
> 						DW_OP_plus_uconst: 332; DW_OP_deref_size: 4;
> 						DW_OP_lit1; DW_OP_shra; DW_OP_const1u: 64;
> 						DW_OP_minus; DW_OP_stack_value)
>     015d8e2c <End of list>
> 
> It looks like '((int *)(-176(%rbp) + 332) >> 1) - 64' but the current
> code thought it's just -176(%rbp) and processed the variable incorrectly.
> It should reject such a complex expression if check_allowed_ops()
> doesn't like it. :)

Looks good to me. Hmm, I should reconsider to support this complex variable
on ftrace probe events...

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Fixes: 932dcc2c39ae ("perf dwarf-aux: Add die_collect_vars()")
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 5e080d7e22c2..beb632153a74 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1598,6 +1598,9 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
>  		return DIE_FIND_CB_SIBLING;
>  
> +	if (!check_allowed_ops(ops, nops))
> +		return DIE_FIND_CB_SIBLING;
> +
>  	if (die_get_real_type(die_mem, &type_die) == NULL)
>  		return DIE_FIND_CB_SIBLING;
>  
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
