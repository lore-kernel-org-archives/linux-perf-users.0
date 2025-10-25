Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4911A2C25;
	Sat, 25 Oct 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761414394; cv=none; b=Z8pV2FjE+jgo5Hgo22SBy1w6NQdS1JHw0LGypLw3f/Aogw89cw1nBq1f56KMg7I6MONi90dpnXRmQKYVvcNkyp4GVWzZ8OvtQUfGMaqZV/30Sud6jy3RzKrgkNP5LWhhmPmzth/wIUUNEtja3oywWZZYMG+jPEozkFIqU/D9cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761414394; c=relaxed/simple;
	bh=pMdDhf7+f8LQWh9TSxUM4Jk25+Fa7+4ZLnX2JnEUCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE1/K0ot9+USgin7rO2WvW1ydIhgvItN4pi9c3uDknjWiDePeUOJcccIU+m9VE0cZZuD7pEEPoX0QCAzN7B4KFpVBCAjVrbDACbSovpKhHtR52WFFfINyruP9EwY26tBgfQPxGwhUK0N0zPhIPoUjBkIRvB5CCHzsMOkfNsNLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfUKa476; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfUKa476"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0652EC4CEF5;
	Sat, 25 Oct 2025 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761414393;
	bh=pMdDhf7+f8LQWh9TSxUM4Jk25+Fa7+4ZLnX2JnEUCtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfUKa476Qh8cj1LE6SmnBD7TJO4qRgjsngRN+098oXTcsgXVFhHvjBL9SlRiGhP1w
	 kckV1zn6pFo9p2QbyP4S+9w9KCJnqBfqgJKch6cqtITj3TG9IwgpytIrAqleiS/7iJ
	 BptM0K5st8ZXh5yfWUIQHgYVDT97kEGuZZwmbeGDiV313MRJ9LvrUjunXsyOeqLo/U
	 MHmqmf2ODLIyDEBtyE4jc38ShOE6XvGcwRATRXzKA3lj7rrHc7r10PMjTje1/e3KJg
	 OxXkuX28iRAkt3pgTmntxrINFLFKg+Bvn/MLXQN89PJ2c1o06q5joOmzO/vjt3Dmnp
	 k41iZT6d2H6Lw==
Date: Sat, 25 Oct 2025 10:46:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] perf annotate: Improve type comparison from
 different scopes
Message-ID: <aP0M95FMF0fB48x9@google.com>
References: <20251013181607.2745653-1-zecheng@google.com>
 <20251013181607.2745653-9-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013181607.2745653-9-zecheng@google.com>

On Mon, Oct 13, 2025 at 06:16:05PM +0000, Zecheng Li wrote:
> When comparing types from different scopes, first compare their type
> offsets. A larger offset means the field belongs to an outer
> (enclosing) struct. This helps resolve cases where a pointer is found
> in an inner scope, but a struct containing that pointer exists in an
> outer scope. Previously, is_better_type would prefer the pointer type,
> but the struct type is actually more complete and should be chosen.

Wouldn't the size check be sufficient?  I think we need to get read of
the pointer preference.

> 
> Prefer types from outer scopes when is_better_type cannot determine
> a better type. This sometimes helps pick a more complete type.

This code has a loop for the scopes so detecting larger struct would
work well?

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate-data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 4b08331b9dd3..4b510eb29a5f 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1629,7 +1629,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  				pr_debug_dtp("type_offset=%#x\n", type_offset);
>  			}
>  
> -			if (!found || is_better_type(type_die, &mem_die)) {
> +			if (!found || dloc->type_offset < type_offset ||
> +				(dloc->type_offset == type_offset &&
> +				 !is_better_type(&mem_die, type_die))) {
>  				*type_die = mem_die;
>  				dloc->type_offset = type_offset;
>  				found = true;
> -- 
> 2.51.0.788.g6d19910ace-goog
> 
