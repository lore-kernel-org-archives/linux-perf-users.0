Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3A3CBE70;
	Sun,  3 May 2026 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851849; cv=none; b=bTZ+bhq149uoReSCjbE62BVH5Q8Nc/Ft69J2sWWMNrqPZD6NBtZ+trgRUt/jpmokPMEy4vadAl2v4P+7dSpR/H1WimrvPBQqqUoPUvt5za4sgQGEocCRR2tSzb0rjF9xXhYi22D78a9XL8YBNthA25u6y7wge8gXWJoRZeL9NgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851849; c=relaxed/simple;
	bh=IiHSQpCGO+AVcgIbWusoBbZTulXZqvNrlh4BcbGbaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL3LiCXoF09JnhNXZFdQYNGffBRbZPN3+hiL6YKMV6Q1YMif+7DH3Nswzsy3ocg1ZsqG/67aKU/K/OWkjmKZ7CQNrnSY5D/mksZGmZXtVHEEnet1lNd3u1W2aw4xefLIt3pQ7vI2oVgeN9yQ6f+m6m1YCGXJ2mM7wqU82OzSmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgSGMGSN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgSGMGSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A0C2BCB4;
	Sun,  3 May 2026 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777851848;
	bh=IiHSQpCGO+AVcgIbWusoBbZTulXZqvNrlh4BcbGbaDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgSGMGSNB1s4PQQuhLiRWWIwREX8RzTwJ9vaJrJmBjpBRrUFdYt4IhIvW378HrS6w
	 C6G5rQiKmpn1yqITFZycnmISiRyDFbJiVlHbOko3vCpyV1ufiF4JhVK7v49hsPETn4
	 FOr6H9a22nW8aWt+BI1EUFjHtWBA4YCip9qa9+GTiVOILSj4Ci0cGw7VUjMKE0Ewl/
	 5Dd7V5iHMHR6rJvKLKl6XljOflRSe9CDSHP3GqiJSWBwasW1kfse6yl/Sx0j22Pt6P
	 MoORvvHuAkLlSNabLykJCpcv49C6g7Oos1Q5fBnJJFHheuVKHzrbSeca7Jp9SNjxtY
	 L8uYy2Eat831g==
Date: Sun, 3 May 2026 16:44:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] perf libdw: Fix libdw API contract violations
Message-ID: <affdxrFU0Wt0-sD5@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-4-irogers@google.com>

On Sun, May 03, 2026 at 10:10:29AM -0700, Ian Rogers wrote:
> Check return values of `dwfl_report_end` and `dwfl_module_addrdie`.
> Check `die_get_call_lineno` for errors.
> 
> Additionally:
>  - Introduce `inline_node__clear_frames()` to clean up partial
>    allocations.

Sounds like it should be a separate commit.


>  - Ensure `*file` is freed and inline frames are cleared on error in
>    `libdw__addr2line()` to prevent memory leaks and duplicated
>    callchains when falling back to other unwinders.
>  - Allow DWARF line 0 in `libdw_a2l_cb()`, as it is a valid
>    reference for compiler-generated code.
>  - Fix the parent srcline lookup in `libdw_a2l_cb()` to target the
>    correct parent node depending on the callchain order
>    (ORDER_CALLER/ORDER_CALLEE).

Also it looks like an independent fix.  While you could put other fixes
into separate commits (up to you), we can merge simple things.

> 
> Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw with that for addr2line")
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v4:
>  - Fix memory leaks and duplicated callchains on unwinding errors.
>  - Support DWARF line 0 in inline list.
>  - Fix callchain parent update in ORDER_CALLER mode.
> ---
>  tools/perf/util/libdw.c   | 84 +++++++++++++++++++++++++++++++--------
>  tools/perf/util/srcline.c |  9 ++++-
>  tools/perf/util/srcline.h |  1 +
>  3 files changed, 77 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index 216977884103..e69ff4cea856 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -4,6 +4,7 @@
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "dwarf-aux.h"
> +#include "callchain.h"
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <elfutils/libdwfl.h>
> @@ -60,7 +61,11 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
>  		return NULL;
>  	}
>  
> -	dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
> +	if (dwfl_report_end(dwfl, NULL, NULL) != 0) {

Better to keep the comments?


> +		dwfl_end(dwfl);
> +		return NULL;
> +	}
> +
>  	dso__set_libdw(dso, dwfl);
>  
>  	return dwfl;
> @@ -72,41 +77,70 @@ struct libdw_a2l_cb_args {
>  	struct inline_node *node;
>  	char *leaf_srcline;
>  	bool leaf_srcline_used;
> +	int err;
>  };
>  
>  static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
>  {
>  	struct libdw_a2l_cb_args *args  = _args;
> -	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
> +	const char *name = dwarf_diename(die);
> +	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, name ?: "unknown");

Use die_getname() here?


>  	const char *call_fname = die_get_call_file(die);
> +	int call_lineno = die_get_call_lineno(die);
>  	char *call_srcline = srcline__unknown;
> -	struct inline_list *ilist;
>  
> -	if (!inline_sym)
> -		return -ENOMEM;
> +	if (!inline_sym) {
> +		args->err = -ENOMEM;
> +		return DWARF_CB_ABORT;
> +	}
>  
>  	/* Assign caller information to the parent. */
> -	if (call_fname)
> -		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
> +	if (call_fname && call_lineno >= 0)
> +		call_srcline = srcline_from_fileline(call_fname, call_lineno);
>  
> -	list_for_each_entry(ilist, &args->node->val, list) {
> -		if (args->leaf_srcline == ilist->srcline)
> +	if (!list_empty(&args->node->val)) {
> +		struct inline_list *parent;
> +
> +		if (callchain_param.order == ORDER_CALLEE)
> +			parent = list_first_entry(&args->node->val, struct inline_list, list);
> +		else
> +			parent = list_last_entry(&args->node->val, struct inline_list, list);
> +
> +		if (args->leaf_srcline == parent->srcline)
>  			args->leaf_srcline_used = false;
> -		else if (ilist->srcline != srcline__unknown)
> -			free(ilist->srcline);
> -		ilist->srcline =  call_srcline;
> +		else if (parent->srcline != srcline__unknown)
> +			free(parent->srcline);
> +		parent->srcline = call_srcline;
>  		call_srcline = NULL;
> -		break;
>  	}
>  	if (call_srcline && call_srcline != srcline__unknown)
>  		free(call_srcline);
>  
>  	/* Add this symbol to the chain as the leaf. */
>  	if (!args->leaf_srcline_used) {
> -		inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
> +		if (inline_list__append_tail(inline_sym, args->leaf_srcline, args->node) != 0) {
> +			args->err = -ENOMEM;
> +			if (inline_sym->inlined)
> +				symbol__delete(inline_sym);
> +			return DWARF_CB_ABORT;
> +		}
>  		args->leaf_srcline_used = true;
>  	} else {
> -		inline_list__append_tail(inline_sym, strdup(args->leaf_srcline), args->node);
> +		char *srcline = strdup(args->leaf_srcline);
> +
> +		if (!srcline) {
> +			args->err = -ENOMEM;
> +			if (inline_sym->inlined)
> +				symbol__delete(inline_sym);
> +			return DWARF_CB_ABORT;
> +		}
> +		if (inline_list__append_tail(inline_sym, srcline, args->node) != 0) {
> +			free(srcline);
> +			args->err = -ENOMEM;
> +			if (inline_sym->inlined)
> +				symbol__delete(inline_sym);
> +			return DWARF_CB_ABORT;

Looks like the pattern is repeated.  My rule is to factor it out when
it repeats more than twice. :)


> +		}
>  	}
>  	return 0;
>  }
> @@ -162,11 +196,29 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  			.leaf_srcline = srcline_from_fileline(src ?: "<unknown>", lineno),
>  		};
>  
> +		if (!args.leaf_srcline) {
> +			if (file && *file) {
> +				free(*file);
> +				*file = NULL;
> +			}
> +			return 0;
> +		}
> +
>  		/* Walk from the parent down to the leaf. */
> -		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
> +		if (cudie)
> +			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
>  
>  		if (!args.leaf_srcline_used)
>  			free(args.leaf_srcline);
> +
> +		if (args.err) {
> +			if (file && *file) {
> +				free(*file);
> +				*file = NULL;
> +			}
> +			inline_node__clear_frames(node);
> +			return 0;
> +		}
>  	}
>  	return 1;
>  }
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index db164d258163..62884428fb5a 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -429,10 +429,13 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
>  	return addr2inlines(dso_name, addr, dso, sym);
>  }
>  
> -void inline_node__delete(struct inline_node *node)
> +void inline_node__clear_frames(struct inline_node *node)
>  {
>  	struct inline_list *ilist, *tmp;
>  
> +	if (node == NULL)
> +		return;
> +
>  	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
>  		list_del_init(&ilist->list);
>  		zfree_srcline(&ilist->srcline);
> @@ -441,7 +444,11 @@ void inline_node__delete(struct inline_node *node)
>  			symbol__delete(ilist->symbol);
>  		free(ilist);
>  	}
> +}
>  
> +void inline_node__delete(struct inline_node *node)
> +{
> +	inline_node__clear_frames(node);
>  	free(node);
>  }
>  
> diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> index 7c37b3bf9ce7..1018cbc886d6 100644
> --- a/tools/perf/util/srcline.h
> +++ b/tools/perf/util/srcline.h
> @@ -47,6 +47,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
>  					    struct symbol *sym);
>  /* free resources associated to the inline node list */
>  void inline_node__delete(struct inline_node *node);
> +void inline_node__clear_frames(struct inline_node *node);
>  
>  /* insert the inline node list into the DSO, which will take ownership */
>  void inlines__tree_insert(struct rb_root_cached *tree,
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
