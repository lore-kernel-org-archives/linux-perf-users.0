Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E974D0A0D;
	Fri, 25 Sep 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350765; cv=none; b=kxNA+ZFHpp3UMAKzwYu3iMUY8Y5SpsaFoPCPJZbFyJsK/Wv4AVz85aZmHDVACkblUgn6yPoK1DWFW8cBEgaPC8nzNNwVy9g/yBE3qGIv0QQ4rf7i7dNWO+bd8YKfxzGPIUj6wgwUbV1xpoPsmAJ4Muok6CumFOAHFD+aVbcMTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350765; c=relaxed/simple;
	bh=8uZqypMBBnuLONuv6PO/bZIAlsnIJLTc4WDw2Ikt6CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On85UoiyEf9e5D6fCWTyg8VSRZetpLMZNOHf+YXxXXih4SYVrYuShwOE3LACX/QSedoKyFOJ8k+NK97rovPj/VmiZ/yxBMZysRDorlY+1mmOYt2lXYMMxOKJTP0vzvt56LfausIpCweMIU0iWwRnPfCRQrSumIBq+XxEbwj5dEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiZYbe0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiZYbe0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC811F000FF;
	Fri, 25 Sep 2026 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350763;
	bh=MmvytYVD+V7IFTWqcn8NRDj2zr9YMw1oJB5yi4QExXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HiZYbe0lEuNt1ZjYE+/UH1P3b9oxxxgzCd9xceOTjnpTp+i6nS1Jtb37baNTkwDnB
	 8EBWuqi4CuoxUIaoiaeT9EQZePjcw1tlUqeJDolFnabaHi7/G/BbiemvEFuxE5P8XY
	 ru03tcEE44iQtVLFb9JyAJeGGCPuKfmxY/qyG0q4zVKbZcCHz8e4LMhEGyuJEIZ5lb
	 kv50LSLj+GcwaE4nwZmNkSAbejPYxK/AGeLpPCZx8SrRqyYurZtPAwR8tS5zuJD5tb
	 qHoAsE5vNt3+l86CMdl6X9g/B3818R2wzQWIDvud6C8+UiAFmwy5hzqgZOVusUtPtr
	 lWrve1AoCo8kg==
Date: Fri, 25 Sep 2026 08:39:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/6] perf annotate-data: Bound the member nesting
 recursion
Message-ID: <araVqTiVF9DpkSmh@z2>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-5-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925150657.1826942-5-acme@kernel.org>

On Fri, Sep 25, 2026 at 05:06:55PM +0200, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Members are added recursively, and a broken DIE can make a member's
> type point back at one of its own ancestors, recursing until the stack
> is gone; nothing usable comes out of nesting members 32 deep anyway, so
> stop there, marking the member as truncated and giving up on member
> types that don't resolve.
> 
> The check is where the children of an aggregate would be expanded, so
> only struct/union members are marked as truncated.
> 
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/annotate-data.c | 20 ++++++++++++++++++--
>  tools/perf/util/annotate-data.h |  3 +++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index bc9698abc6a9e055..19a6ecd67f28719d 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -222,6 +222,12 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
>  	return strcmp(a->self.type_name, b->self.type_name) < 0;
>  }
>  
> +/*
> + * A broken type can point back at one of its own ancestors: bound the
> + * nesting so it doesn't recurse until the stack is gone.
> + */
> +#define MAX_MEMBER_DEPTH 32
> +
>  /* Recursively add new members for struct/union */
>  static int __add_member_cb(Dwarf_Die *die, void *arg)
>  {
> @@ -236,6 +242,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	if (dwarf_tag(die) != DW_TAG_member)
>  		return DIE_FIND_CB_SIBLING;
>  
> +	if (die_get_real_type(die, &die_mem) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
>  	member = zalloc(sizeof(*member));
>  	if (member == NULL)
>  		return DIE_FIND_CB_END;
> @@ -248,8 +257,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	if (die_get_typename(die, &sb) < 0)
>  		strbuf_add(&sb, "(unknown type)", 14);
>  
> -	die_get_real_type(die, &die_mem);
> -
>  	if (dwarf_aggregate_size(&die_mem, &size) < 0 || size == 0) {
>  		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
>  			die_get_real_type(&die_mem, &die_mem);
> @@ -299,6 +306,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	}
>  	member->size = size;
>  	member->offset = loc + parent->offset;
> +	member->depth = parent->depth + 1;
>  	INIT_LIST_HEAD(&member->children);
>  
>  	list_for_each_entry_reverse(prev, &parent->children, node) {
> @@ -313,6 +321,14 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  		member->is_union = true;
>  		/* fall through */
>  	case DW_TAG_structure_type:
> +		/* Only aggregates have children to expand, so only they get truncated. */
> +		if (member->depth >= MAX_MEMBER_DEPTH) {
> +			/* Consumed by the JSON exporter added in a later series. */
> +			member->truncated = true;
> +			pr_debug_dtp("member nesting limit reached at %s\n",
> +				     member->type_name ?: "(unknown type)");
> +			break;
> +		}
>  		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
>  		break;
>  	default:
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 14b8113521a927cf..ca0abfb2a036d229 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -61,6 +61,9 @@ struct annotated_member {
>  	int size;
>  	bool is_union;
>  	bool is_flex_array;
> +	unsigned int depth;
> +	/* Children not expanded because the nesting limit was reached */
> +	bool truncated;

Nit: it'd be better to switch the order of the last two fields to reduce
the padding.

Thanks,
Namhyung

>  };
>  
>  /**
> -- 
> 2.53.0
> 
