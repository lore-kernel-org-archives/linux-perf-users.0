Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE72B2D7;
	Mon,  3 Feb 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623651; cv=none; b=dtJK8TR2SaIzTW9QVW9MYU3LEwrMvJF++C3/MSEG8kCPIpHzjFh6W93skixx2X9zgbil/I6QKCCO+DrvO+uuJHuULf0PfpzKut+jiAIW+UO2Vk3qSrZpHlTCea+Egzr4NnotG4h35zNcwVzwyEjxgKyPYz3iFcWgovSxAH7+0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623651; c=relaxed/simple;
	bh=UuLsrrtIQ9EGNdf/Z2srTqdy1WKORJrbeTLu34pu0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGP62bVcsOwqQyRhuPRWhFCN3NyC9YFAJ3I4oOLrwOTkmSBNTVxJ7Zvaf1fW6+7y3UflkEYoLbkjWUCbAG0rW0Cv+y2DeBlLhQW5DqxnnoMFYjb6u5ARIVfQcLjWlNk6H47UCBZ82Va9y3DrdHDcQC7WJVhGl8CdnMw7B+y6CXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOQpeMvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOQpeMvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE4C4CEE0;
	Mon,  3 Feb 2025 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738623651;
	bh=UuLsrrtIQ9EGNdf/Z2srTqdy1WKORJrbeTLu34pu0Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOQpeMvf6+1NlZHSjN/OVOHPUW55LIbJpefKxLHpj9AImfWNcJf16TmCzD3f2Chah
	 BnivGG6a1bx7ca3cnPUmDPP7dnjZWDk6sey5ixc+p2WvnpSpXvLnLGhR4XGVdAWvmG
	 Oa2MUeK6vJ9ghPSF4CfM4oP+KxcCQaU3mJ/ne3AK3BZqQ8Ig9ExfY++cwa/3X+X/UZ
	 XoMDJui61XUXTm0wIO2MMVGpFDfBgktbTMUOw8IhdfElxiWbSHjpf75LBHtBJFcPQG
	 yblddBYhT1jUHqklaOd5V5j4FD4DNVtl0akBLsHpiLJaEHtgWzrQWemF0ZHZ02IkvI
	 rXsswpHReHipQ==
Date: Mon, 3 Feb 2025 15:00:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf pmu: Rename name matching for no suffix or
 wildcard variants
Message-ID: <Z6FKoQfY2zBNzIZV@google.com>
References: <20250201074320.746259-1-irogers@google.com>
 <20250201074320.746259-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250201074320.746259-4-irogers@google.com>

Hi Ian,

On Fri, Jan 31, 2025 at 11:43:18PM -0800, Ian Rogers wrote:
> Wildcard PMU naming will match a name like pmu_1 to a PMU name like
> pmu_10 but not to a PMU name like pmu_2 as the suffix forms part of
> the match. No suffix matching will match pmu_10 to either pmu_1 or
> pmu_2. Add or rename matching functions on PMU to make it clearer what
> kind of matching is being performed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/empty-pmu-events.c |   8 +-
>  tools/perf/pmu-events/jevents.py         |   8 +-
>  tools/perf/tests/pmu.c                   |  85 ++++----
>  tools/perf/util/parse-events.c           |   2 +-
>  tools/perf/util/pmu.c                    | 256 ++++++++++++++++-------
>  tools/perf/util/pmu.h                    |   5 +-
>  6 files changed, 235 insertions(+), 129 deletions(-)
> 
[...]
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6206c8fe2bf9..c2a15b0259cf 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -847,21 +847,23 @@ static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
>  }
>  
>  /**
> - * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
> - *                                   trailing suffix? The Suffix must be in form
> - *                                   tok_{digits}, or tok{digits}.
> + * perf_pmu__match_wildcard - Does the pmu_name start with tok and is then only
> + *                            followed by nothing or a suffix? tok may contain
> + *                            part of a suffix.
>   * @pmu_name: The pmu_name with possible suffix.
> - * @tok: The possible match to pmu_name without suffix.
> + * @tok: The wildcard argument to match.
>   */
> -static bool perf_pmu__match_ignoring_suffix(const char *pmu_name, const char *tok)
> +static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)

It'd be nice if we use a function prefix with "__" only if the first
argument is the corresponding type.  How about renaming it to
pmu_name_match_wildcard() and others?

Otherwise, looks good to me.

Thanks,
Namhyung


>  {
>  	const char *p, *suffix;
>  	bool has_hex = false;
> +	size_t tok_len = strlen(tok);
>  
> -	if (strncmp(pmu_name, tok, strlen(tok)))
> +	/* Check start of pmu_name for equality. */
> +	if (strncmp(pmu_name, tok, tok_len))
>  		return false;
>  
> -	suffix = p = pmu_name + strlen(tok);
> +	suffix = p = pmu_name + tok_len;
>  	if (*p == 0)
>  		return true;
>  
> @@ -887,60 +889,84 @@ static bool perf_pmu__match_ignoring_suffix(const char *pmu_name, const char *to
>  }
>  
>  /**
> - * pmu_uncore_alias_match - does name match the PMU name?
> - * @pmu_name: the json struct pmu_event name. This may lack a suffix (which
> + * perf_pmu__match_ignoring_suffix_uncore - Does the pmu_name match tok ignoring
> + *                                          any trailing suffix on pmu_name and
> + *                                          tok?  The Suffix must be in form
> + *                                          tok_{digits}, or tok{digits}.
> + * @pmu_name: The pmu_name with possible suffix.
> + * @tok: The possible match to pmu_name.
> + */
> +static bool perf_pmu__match_ignoring_suffix_uncore(const char *pmu_name, const char *tok)
> +{
> +	size_t pmu_name_len, tok_len;
> +
> +	/* For robustness, check for NULL. */
> +	if (pmu_name == NULL)
> +		return tok == NULL;
> +
> +	/* uncore_ prefixes are ignored. */
> +	if (!strncmp(pmu_name, "uncore_", 7))
> +		pmu_name += 7;
> +	if (!strncmp(tok, "uncore_", 7))
> +		tok += 7;
> +
> +	pmu_name_len = pmu_name_len_no_suffix(pmu_name);
> +	tok_len = pmu_name_len_no_suffix(tok);
> +	if (pmu_name_len != tok_len)
> +		return false;
> +
> +	return strncmp(pmu_name, tok, pmu_name_len) == 0;
> +}
> +
> +
> +/**
> + * perf_pmu__match_wildcard_uncore - does to_match match the PMU's name?
> + * @pmu_name: The pmu->name or pmu->alias to match against.
> + * @to_match: the json struct pmu_event name. This may lack a suffix (which
>   *            matches) or be of the form "socket,pmuname" which will match
>   *            "socketX_pmunameY".
> - * @name: a real full PMU name as from sysfs.
>   */
> -static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> +static bool perf_pmu__match_wildcard_uncore(const char *pmu_name, const char *to_match)
>  {
> -	char *tmp = NULL, *tok, *str;
> -	bool res;
> -
> -	if (strchr(pmu_name, ',') == NULL)
> -		return perf_pmu__match_ignoring_suffix(name, pmu_name);
> +	char *mutable_to_match, *tok, *tmp;
>  
> -	str = strdup(pmu_name);
> -	if (!str)
> +	if (!pmu_name)
>  		return false;
>  
> -	/*
> -	 * uncore alias may be from different PMU with common prefix
> -	 */
> -	tok = strtok_r(str, ",", &tmp);
> -	if (strncmp(pmu_name, tok, strlen(tok))) {
> -		res = false;
> -		goto out;
> -	}
> +	/* uncore_ prefixes are ignored. */
> +	if (!strncmp(pmu_name, "uncore_", 7))
> +		pmu_name += 7;
> +	if (!strncmp(to_match, "uncore_", 7))
> +		to_match += 7;
>  
> -	/*
> -	 * Match more complex aliases where the alias name is a comma-delimited
> -	 * list of tokens, orderly contained in the matching PMU name.
> -	 *
> -	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
> -	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
> -	 *	    "pmunameY".
> -	 */
> -	while (1) {
> -		char *next_tok = strtok_r(NULL, ",", &tmp);
> +	if (strchr(to_match, ',') == NULL)
> +		return perf_pmu__match_wildcard(pmu_name, to_match);
>  
> -		name = strstr(name, tok);
> -		if (!name ||
> -		    (!next_tok && !perf_pmu__match_ignoring_suffix(name, tok))) {
> -			res = false;
> -			goto out;
> +	/* Process comma separated list of PMU name components. */
> +	mutable_to_match = strdup(to_match);
> +	if (!mutable_to_match)
> +		return false;
> +
> +	tok = strtok_r(mutable_to_match, ",", &tmp);
> +	while (tok) {
> +		size_t tok_len = strlen(tok);
> +
> +		if (strncmp(pmu_name, tok, tok_len)) {
> +			/* Mismatch between part of pmu_name and tok. */
> +			free(mutable_to_match);
> +			return false;
>  		}
> -		if (!next_tok)
> -			break;
> -		tok = next_tok;
> -		name += strlen(tok);
> +		/* Move pmu_name forward over tok and suffix. */
> +		pmu_name += tok_len;
> +		while (*pmu_name != '\0' && isdigit(*pmu_name))
> +			pmu_name++;
> +		if (*pmu_name == '_')
> +			pmu_name++;
> +
> +		tok = strtok_r(NULL, ",", &tmp);
>  	}
> -
> -	res = true;
> -out:
> -	free(str);
> -	return res;
> +	free(mutable_to_match);
> +	return *pmu_name == '\0';
>  }
>  
>  bool pmu_uncore_identifier_match(const char *compat, const char *id)
> @@ -1003,11 +1029,19 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>  {
>  	struct perf_pmu *pmu = vdata;
>  
> -	if (!pe->compat || !pe->pmu)
> +	if (!pe->compat || !pe->pmu) {
> +		/* No data to match. */
>  		return 0;
> +	}
> +
> +	if (!perf_pmu__match_wildcard_uncore(pmu->name, pe->pmu) &&
> +	    !perf_pmu__match_wildcard_uncore(pmu->alias_name, pe->pmu)) {
> +		/* PMU name/alias_name don't match. */
> +		return 0;
> +	}
>  
> -	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> -	    pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> +	if (pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> +		/* Id matched. */
>  		perf_pmu__new_alias(pmu,
>  				pe->name,
>  				pe->desc,
> @@ -1016,7 +1050,6 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>  				pe,
>  				EVENT_SRC_SYS_JSON);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -1974,15 +2007,82 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	return ret;
>  }
>  
> -bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
> +static bool perf_pmu___name_match(const struct perf_pmu *pmu, const char *to_match, bool wildcard)
>  {
> -	return !strcmp(pmu->name, pmu_name) ||
> -		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name)) ||
> +	const char *names[2] = {
> +		pmu->name,
> +		pmu->alias_name,
> +	};
> +	if (pmu->is_core) {
> +		for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
> +			const char *name = names[i];
> +
> +			if (!name)
> +				continue;
> +
> +			if (!strcmp(name, to_match)) {
> +				/* Exact name match. */
> +				return true;
> +			}
> +		}
> +		if (!strcmp(to_match, "default_core")) {
> +			/*
> +			 * jevents and tests use default_core as a marker for any core
> +			 * PMU as the PMU name varies across architectures.
> +			 */
> +			return true;
> +		}
> +		return false;
> +	}
> +	if (!pmu->is_uncore) {
>  		/*
> -		 * jevents and tests use default_core as a marker for any core
> -		 * PMU as the PMU name varies across architectures.
> +		 * PMU isn't core or uncore, some kind of broken CPU mask
> +		 * situation. Only match exact name.
>  		 */
> -	        (pmu->is_core && !strcmp(pmu_name, "default_core"));
> +		for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
> +			const char *name = names[i];
> +
> +			if (!name)
> +				continue;
> +
> +			if (!strcmp(name, to_match)) {
> +				/* Exact name match. */
> +				return true;
> +			}
> +		}
> +		return false;
> +	}
> +	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
> +		const char *name = names[i];
> +
> +		if (wildcard && perf_pmu__match_wildcard_uncore(name, to_match))
> +			return true;
> +		if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(name, to_match))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * perf_pmu__name_wildcard_match - Called by the jevents generated code to see
> + *                                 if pmu matches the json to_match string.
> + * @pmu: The pmu whose name/alias to match.
> + * @to_match: The possible match to pmu_name.
> + */
> +bool perf_pmu__name_wildcard_match(const struct perf_pmu *pmu, const char *to_match)
> +{
> +	return perf_pmu___name_match(pmu, to_match, /*wildcard=*/true);
> +}
> +
> +/**
> + * perf_pmu__name_no_suffix_match - Does pmu's name match to_match ignoring any
> + *                                  trailing suffix on the pmu_name and/or tok?
> + * @pmu: The pmu whose name/alias to match.
> + * @to_match: The possible match to pmu_name.
> + */
> +bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const char *to_match)
> +{
> +	return perf_pmu___name_match(pmu, to_match, /*wildcard=*/false);
>  }
>  
>  bool perf_pmu__is_software(const struct perf_pmu *pmu)
> @@ -2229,29 +2329,31 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  		   name ?: "N/A", buf, config_name, config);
>  }
>  
> -bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
> +bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *wildcard_to_match)
>  {
> -	const char *name = pmu->name;
> -	bool need_fnmatch = strisglob(tok);
> +	const char *names[2] = {
> +		pmu->name,
> +		pmu->alias_name,
> +	};
> +	bool need_fnmatch = strisglob(wildcard_to_match);
>  
> -	if (!strncmp(tok, "uncore_", 7))
> -		tok += 7;
> -	if (!strncmp(name, "uncore_", 7))
> -		name += 7;
> +	if (!strncmp(wildcard_to_match, "uncore_", 7))
> +		wildcard_to_match += 7;
>  
> -	if (perf_pmu__match_ignoring_suffix(name, tok) ||
> -	    (need_fnmatch && !fnmatch(tok, name, 0)))
> -		return true;
> +	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
> +		const char *pmu_name = names[i];
>  
> -	name = pmu->alias_name;
> -	if (!name)
> -		return false;
> +		if (!pmu_name)
> +			continue;
>  
> -	if (!strncmp(name, "uncore_", 7))
> -		name += 7;
> +		if (!strncmp(pmu_name, "uncore_", 7))
> +			pmu_name += 7;
>  
> -	return perf_pmu__match_ignoring_suffix(name, tok) ||
> -		(need_fnmatch && !fnmatch(tok, name, 0));
> +		if (perf_pmu__match_wildcard(pmu_name, wildcard_to_match) ||
> +		    (need_fnmatch && !fnmatch(wildcard_to_match, pmu_name, 0)))
> +			return true;
> +	}
> +	return false;
>  }
>  
>  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index edd36c20aedc..f5306428c03f 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -240,7 +240,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name);
>  size_t perf_pmu__num_events(struct perf_pmu *pmu);
>  int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  			     void *state, pmu_event_callback cb);
> -bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
> +bool perf_pmu__name_wildcard_match(const struct perf_pmu *pmu, const char *to_match);
> +bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const char *to_match);
>  
>  /**
>   * perf_pmu_is_software - is the PMU a software PMU as in it uses the
> @@ -275,7 +276,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  				   const char *config_name);
>  void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
>  
> -bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok);
> +bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *wildcard_to_match);
>  
>  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
>  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> -- 
> 2.48.1.362.g079036d154-goog
> 
