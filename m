Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AE30E835;
	Wed, 11 Feb 2026 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776755; cv=none; b=oFDWiJKaZuGuMjbx+aFkNamyfghx08KS5afdA3KTDsxSor/OqzJmPOq7NPzj2PupNLmrHGN7hdK5UlLn2lVzdCm4nPUIVTMVwl90T7im+nT7vya0UFKBPCtwqKFfZuI7kkT3X8IoQcZUV/AGqWpAJs6VZzmEW03n3bp+LqxKah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776755; c=relaxed/simple;
	bh=kfKInsQaMl1dx9m1/oAa3Kn4iFBCsiFt8oNfev0CAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnaas1tYUWmUCOjLSs9IlWE6fHWnfgDCA2nhAXGzJzRl7k/sn7qgNHbX9BYOpH6Hn5bacQn9/hC6xpPtxi2wo6vceTuA3eaWw8ChTDCABRjcChl84JN/8Lbu6UOXK5klahsEa0ggQy3fVMFuaHbgXIDyqe/wtOAPsifu7mMJY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr9s3m5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr9s3m5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E79C116C6;
	Wed, 11 Feb 2026 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776755;
	bh=kfKInsQaMl1dx9m1/oAa3Kn4iFBCsiFt8oNfev0CAIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cr9s3m5Pcjvf5KziR8dbevZdjECBykU6B1xtrDIFEgT/UHQpiOltsfjSuTukvI4gl
	 5e4fFwf5uVMZfJxb0KpKbBm55OXki1XbjV3VaJUqOJfEcaFE317DskBbC46FrxAhcY
	 gouO3xzbIK4Jzp3Iu6QVL0zijEmvI1WzoS1gzebTIEllNAH5xn4Q5ZvWOVRDAFwHyp
	 Me4C5jmYJD4NkNbsXa0cwzU4Dn/qdlR6GGvcpdd+53x+gHAnsZSNI9JXVxZ3j0yOFm
	 sBYsqhENk+VRMtj/aH2WrWvvD7jLgBzmxAjcRk6n0PRh0HT636gGCLtrOYFmx7wUDh
	 Txsb0o69KBIMQ==
Date: Tue, 10 Feb 2026 18:25:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: Re: [PATCH v1 04/11] perf annotate-data: Improve type comparison
 from different scopes
Message-ID: <aYvosW_R6XjGmVSm@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-5-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-5-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:04:57PM -0500, Zecheng Li wrote:
> From: Zecheng Li <zecheng@google.com>
> 
> When comparing types from different scopes, first compare their type
> offsets. A larger offset means the field belongs to an outer
> (enclosing) struct. This helps resolve cases where a pointer is found
> in an inner scope, but a struct containing that pointer exists in an
> outer scope. Previously, is_better_type would prefer the pointer type,
> but the struct type is actually more complete and should be chosen.
> 
> Prefer types from outer scopes when is_better_type cannot determine
> a better type. This is a heuristic for the case `struct A { struct B; }`
> where A and B have the same size but I think in most cases A is in the
> outer scope and should be preferred.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate-data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 8ff1972981b7..8ea3e8b024e8 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1634,7 +1634,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  				pr_debug_dtp("type_offset=%#x\n", type_offset);
>  			}
>  
> -			if (!found || is_better_type(type_die, &mem_die)) {
> +			if (!found || dloc->type_offset < type_offset ||
> +			    (dloc->type_offset == type_offset &&
> +			     !is_better_type(&mem_die, type_die))) {
>  				*type_die = mem_die;
>  				dloc->type_offset = type_offset;
>  				found = true;
> -- 
> 2.52.0
> 
