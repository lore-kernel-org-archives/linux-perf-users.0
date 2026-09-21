Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF92361DA6;
	Mon, 21 Sep 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971736; cv=none; b=s7STxaNScDW1FJfLbWUChQGfcnAWU5ZZ3Tq1IX7hUQ7gXiCrKavHTNMOSGgYdkR6R7LYRoN2w8izpdLCJYWgUTO7YF+MQttcDYQNdE+zU9m72hk06y0hflROA3IMEzDpvY2BRdsLohfpmCfLx83y1z0HQDPtABS4c7F94o8kxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971736; c=relaxed/simple;
	bh=z4aAwBgqIqyloe3Ukq3nEoAvkilgAieGKqiScaNkon0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDng8Kg+o+CzaVoZbV6GnTqHCYfYfYn+IfbJdtsDUsIm1a9l8rrc+sx+HwdXIKpNY9a4MviSgeI1lVxH3kOOaxXZKI+RrfMIu15DiSefbDYJggT1qhE+bL7cUhpCNTozbBPdjZ4lEkdt9SVxw+6gtl90/r4VmmY4QNwhDjIn1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUnUaSif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUnUaSif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2199C1F000FF;
	Mon, 21 Sep 2026 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789971735;
	bh=uZdMkJDAp6rJM26htnZk7E9JkWCMMA4T82aVyiUlmqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YUnUaSifIgxamcrokCMOKJ6nQqnda7HcYwNosNqYbj649Wcsu9+4sdghAmf6eOjOg
	 n2KbKE246kifwadd0SRpes9i/Sm6tBknVV8hgjFVqbiFACYLxnKHzT/uWQ1jrRSo0S
	 5q2sh7oe6rbw5JfdGZnb71Z4WWWsWbMErdkgpPlwMp1JDO/+31qdv4sOopB0e5K+Hb
	 Y+RIuEfQ7/aoAcZL9aUKZ/56sZBr66S+Xiz6Zl9VSZVMNpsYgjYOGp4/TkSEjq24QY
	 P7uyIsbdLZPBDcHnSHrxfluNxa5nM3t2JXR7vcC5U+cRbXmHDm3sZAS3FC6KDMShsf
	 bqtO5csm8cyFQ==
Date: Sun, 20 Sep 2026 23:22:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/7] perf annotate-data: Bound the member nesting
 recursion
Message-ID: <arDNFYI5PvIF40GF@z2>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-5-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919204027.8504-5-acme@kernel.org>

On Sat, Sep 19, 2026 at 05:40:24PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Members are added recursively, and the same kind of broken DIE can make
> a member's type point back at one of its own ancestors, recursing until
> the stack is gone; nothing usable comes out of nesting members 8 deep
> anyway, so stop there, marking the member as truncated (reported by the
> JSON exporter added in a later series) and giving up on member types
> that don't resolve.

I think 8 is too restrictive.  It should be common to have 3 or 4 depth
if you have nested struct or union members.

And some kernel primitives like spinlock also have nested members like

  raw_spinlock_t
    arch_spinlock_t
      union
        atomic_t
	  int

So it'd be easy to hit the limit when the nested members contain a
spinlock.

Thanks,
Namhyung

> 
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/annotate-data.c | 32 ++++++++++++++++++++++++++------
>  tools/perf/util/annotate-data.h |  3 +++
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 2ad6d012e069c522..c67bb6005e23c516 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -221,6 +221,13 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
>  	return strcmp(a->self.type_name, b->self.type_name) < 0;
>  }
>  
> +/*
> + * Members are added recursively; bound the nesting so that a broken
> + * type that points back at one of its own ancestors doesn't recurse
> + * until the stack is gone.
> + */
> +#define MAX_MEMBER_DEPTH 8
> +
>  /* Recursively add new members for struct/union */
>  static int __add_member_cb(Dwarf_Die *die, void *arg)
>  {
> @@ -235,6 +242,16 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	if (dwarf_tag(die) != DW_TAG_member)
>  		return DIE_FIND_CB_SIBLING;
>  
> +	if (__die_get_real_type(die, &member_type) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (dwarf_tag(&member_type) == DW_TAG_typedef) {
> +		if (die_get_real_type(&member_type, &die_mem) == NULL)
> +			return DIE_FIND_CB_SIBLING;
> +	} else {
> +		die_mem = member_type;
> +	}
> +
>  	member = zalloc(sizeof(*member));
>  	if (member == NULL)
>  		return DIE_FIND_CB_END;
> @@ -242,12 +259,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	strbuf_init(&sb, 32);
>  	die_get_typename(die, &sb);
>  
> -	__die_get_real_type(die, &member_type);
> -	if (dwarf_tag(&member_type) == DW_TAG_typedef)
> -		die_get_real_type(&member_type, &die_mem);
> -	else
> -		die_mem = member_type;
> -
>  	if (dwarf_aggregate_size(&die_mem, &size) < 0)
>  		size = 0;
>  
> @@ -289,10 +300,19 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	}
>  	member->size = size;
>  	member->offset = loc + parent->offset;
> +	member->depth = parent->depth + 1;
>  	INIT_LIST_HEAD(&member->children);
>  	list_add_tail(&member->node, &parent->children);
>  
>  	tag = dwarf_tag(&die_mem);
> +	if (member->depth >= MAX_MEMBER_DEPTH) {
> +		/* Reported by the JSON exporter so consumers can tell a truncated tree. */
> +		member->truncated = true;
> +		pr_debug_dtp("member nesting limit reached at %s\n",
> +			     member->type_name ?: "(unknown type)");
> +		return DIE_FIND_CB_SIBLING;
> +	}
> +
>  	switch (tag) {
>  	case DW_TAG_structure_type:
>  	case DW_TAG_union_type:
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index ca2096a9ee62cbfe..cc576232f55b5fb0 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -57,6 +57,9 @@ struct annotated_member {
>  	char *var_name;
>  	int offset;
>  	int size;
> +	unsigned int depth;
> +	/* Children not expanded because the nesting limit was reached */
> +	bool truncated;
>  };
>  
>  /**
> -- 
> 2.53.0
> 
