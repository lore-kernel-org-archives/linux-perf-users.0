Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85648191F80;
	Wed,  3 Jul 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043185; cv=none; b=sBc5Jn0wumLsATQkhUnfbw5sy5a+skTYOIjsUZA1+lWPV9JxNL0Qx/r/x+x5F91xLHMYyYt2SxwCtLlLndiM9H8PRtzRGu27L1iRsTJ5uN/2hmr9SASwiy/lYM127eeWozZ/O68kyetczXuu/o2CQ9qBbKnLVw098t1t1CrSLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043185; c=relaxed/simple;
	bh=rzyAx0if7a3pooGOlXnjoWuU+FC+0U5nSUt348PlNAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Skrs8eDbKqEKqHeniGxKGTyhRi+r8l6Tzmkc/RTkcj8R3YaR5Td8OfLeJbtQPwluoW9FMgjoRaPqxmGEKeI2gI4Q/VmXg4x87aHRUgPLm3yYtDzCKE8EGS5QXPi0mhzN/Wn23QJ9CYEfbZVD9HmzLhtcHm3KyT1GjqQ6XgvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsqfLFoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsqfLFoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93248C2BD10;
	Wed,  3 Jul 2024 21:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720043185;
	bh=rzyAx0if7a3pooGOlXnjoWuU+FC+0U5nSUt348PlNAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsqfLFoZw8rAHMO83S5+aPRk86qaxyVJxqm6ZzAD9I29uqVRdWl/8l93Vqc1HJB8m
	 ZoCNO4FTG4RE9XZaw3gTNb64lEuLP1WvWJB9gPH7jjRnaLzNIi/iEqH96VGUQNHAMZ
	 EcAarZg1gS7wBJ6QqJLMsA7SGbtLS+rkY1+t65uRnV5iQLAjwUT4nxF+QfEvf5zlSA
	 RmbC+Bk3iXlUU0kn0cq9cseB594kHYA6W6Bvvozgdg6ic6n3G9xbudTqNt3UxxJxt9
	 h/oawc3s1IIyL+t65Ecivo7TlVm80JgtsAZ6IfVPBinhXAL7+SsdJ8M+jy7xZZmc++
	 spzoY126CyoQQ==
Date: Wed, 3 Jul 2024 14:46:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steinar Gunderson <sesse@google.com>,
	Matt Fleming <matt@readmodwrite.com>
Subject: Re: [PATCH v1 2/2] perf dsos: When adding a dso into sorted dsos
 maintain the sort order
Message-ID: <ZoXGr2skcDZTUb5U@google.com>
References: <20240703172117.810918-1-irogers@google.com>
 <20240703172117.810918-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703172117.810918-3-irogers@google.com>

On Wed, Jul 03, 2024 at 10:21:17AM -0700, Ian Rogers wrote:
> dsos__add would add at the end of the dso array possibly requiring a
> later find to re-sort the array. Patterns of find then add were
> becoming O(n*log n) due to the sorts. Change the add routine to be
> O(n) rather than O(1) but to maintain the sorted-ness of the dsos
> array so that later finds don't need the O(n*log n) sort.
> 
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

It works well for me too!

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 5e5e05f86dd3..d4acdb37f046 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -206,11 +206,27 @@ int __dsos__add(struct dsos *dsos, struct dso *dso)
>  		dsos->dsos = temp;
>  		dsos->allocated = to_allocate;
>  	}
> -	dsos->dsos[dsos->cnt++] = dso__get(dso);
> -	if (dsos->cnt >= 2 && dsos->sorted) {
> -		dsos->sorted = dsos__cmp_long_name_id_short_name(&dsos->dsos[dsos->cnt - 2],
> -								 &dsos->dsos[dsos->cnt - 1])
> -			<= 0;
> +	if (!dsos->sorted) {
> +		dsos->dsos[dsos->cnt++] = dso__get(dso);
> +	} else {
> +		int low = 0, high = dsos->cnt - 1;
> +		int insert = dsos->cnt; /* Default to inserting at the end. */
> +
> +		while (low <= high) {
> +			int mid = low + (high - low) / 2;
> +			int cmp = dsos__cmp_long_name_id_short_name(&dsos->dsos[mid], &dso);
> +
> +			if (cmp < 0) {
> +				low = mid + 1;
> +			} else {
> +				high = mid - 1;
> +				insert = mid;
> +			}
> +		}
> +		memmove(&dsos->dsos[insert + 1], &dsos->dsos[insert],
> +			(dsos->cnt - insert) * sizeof(struct dso *));
> +		dsos->cnt++;
> +		dsos->dsos[insert] = dso__get(dso);
>  	}
>  	dso__set_dsos(dso, dsos);
>  	return 0;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
