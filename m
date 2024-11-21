Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CB126F1E;
	Thu, 21 Nov 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168195; cv=none; b=QPESoW0WQhfPNa/2iopnPHaasbXCjugva6yrQk1rhSQjGpKblXoTbzyGMhyB8pVLgfIsTJoaEBcMGyXNmj3Ttc1Fd8bybodm30GyDSZjyVr0TND30mwDHgQ8lsKrOiRdHAWaNh+vy9DFxZahgk/xJt9eMP0tc0NBTEDUiqXKM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168195; c=relaxed/simple;
	bh=ftB/0JAA7nn+qWIsDHXXMq9e0XJWTR9zvGVDhuL+05s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3hLjZiXpdF9ezHJe5NrEcFSgZku2HrwLbBkWWg2n1BWlTWfBOb853r7AlTVzVRFlXsxi08fSwgN7hVbGJ89JK6kKcIOFDj+XXyIDt+603ojmya0JnTExrMoG3Eg/EHu0Ki5Z8rRQ5XKEzeoYTjBTRjtnwZzqMTyru2EH1yNYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv8ersnr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv8ersnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEBAC4CECC;
	Thu, 21 Nov 2024 05:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732168195;
	bh=ftB/0JAA7nn+qWIsDHXXMq9e0XJWTR9zvGVDhuL+05s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zv8ersnrqqB0CgVGSt3xV+p+q4ohPQ1MAugTrbtGk+1bm4Ew9X0o/OK65baXjRyZS
	 xHuetImwtSznEDZD0+97ll/BzwLFYcW8kOWIw/zj1zV/6/izrONB0lF3aObPWWRD85
	 8wyUkt04ESLm1l6eDzxfL6CCUiId9py6Or1QdjIiXR/nJAeoJeoKzhEY+WI0CxRS6k
	 qah1zEZt/FYSpRoi3ZntcGRCvh3ZYzQ1m4lYDTw2TZRPrfxdWTc4c0KMnUNHZElGha
	 diwoAg5P8GfqMhIhKMTAgQV7JcYew6950blgCSpSthojvZDsuwq1800PCN2bJ6a/82
	 XRoxuGRp0jYFQ==
Date: Wed, 20 Nov 2024 21:49:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
Message-ID: <Zz7KAAG2pHhCg-Dx@google.com>
References: <20241121000955.536930-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121000955.536930-1-irogers@google.com>

On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> address issue with hwmon_pmu__config_terms needing to load events - a
> load bearing assert fired. Also fix missing list deletion when putting
> the hwmon test PMU and lower some debug warnings to make the hwmon PMU
> less spammy in verbose mode.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/hwmon_pmu.c |  5 +++--
>  tools/perf/util/hwmon_pmu.c  | 16 ++++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index d8bc71b51599..b4656529146e 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -41,6 +41,7 @@ static int test_pmu_put(const char *dir, struct perf_pmu *hwm)
>  	if (ret)
>  		pr_err("Failure to \"%s\"\n", buf);
>  
> +	list_del(&hwm->list);
>  	perf_pmu__delete(hwm);
>  	return ret;
>  }
> @@ -147,7 +148,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
>  	}
>  
>  	if (with_pmu)
> -		snprintf(str, sizeof(str), "/%s/", test_event);
> +		snprintf(str, sizeof(str), "hwmon_a_test_hwmon_pmu/%s/", test_event);
>  	else
>  		strlcpy(str, test_event, sizeof(str));
>  
> @@ -230,7 +231,7 @@ static int test__hwmon_pmu_without_pmu(struct test_suite *test __maybe_unused,
>  static int test__hwmon_pmu_with_pmu(struct test_suite *test __maybe_unused,
>  				   int subtest __maybe_unused)
>  {
> -	return test__hwmon_pmu(/*with_pmu=*/false);
> +	return test__hwmon_pmu(/*with_pmu=*/true);
>  }
>  
>  static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index 4d9d6f405434..e61429b38ba7 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -197,13 +197,13 @@ bool parse_hwmon_filename(const char *filename,
>  		}
>  	}
>  	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
> -		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
> +		pr_debug3("hwmon_pmu: not a hwmon file '%s'\n", filename);
>  		return false;
>  	}
>  	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
>  		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);
>  	if (!elem) {
> -		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
> +		pr_debug3("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
>  			 fn_type, filename);
>  		return false;
>  	}
> @@ -223,7 +223,7 @@ bool parse_hwmon_filename(const char *filename,
>  	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
>  		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
>  	if (!elem) {
> -		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
> +		pr_debug3("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
>  			 fn_item, filename);
>  		return false;
>  	}
> @@ -281,7 +281,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
>  			continue;
>  
>  		if (!parse_hwmon_filename(ent->d_name, &type, &number, &item, &alarm)) {
> -			pr_debug("Not a hwmon file '%s'\n", ent->d_name);
> +			pr_debug3("Not a hwmon file '%s'\n", ent->d_name);
>  			continue;
>  		}
>  		key.num = number;
> @@ -653,10 +653,14 @@ int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
>  			    struct parse_events_terms *terms,
>  			    struct parse_events_error *err)
>  {
> -	const struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
> +	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
>  	struct parse_events_term *term;
> +	int ret;
> +
> +	ret = hwmon_pmu__read_events(hwm);
> +	if (ret)
> +		return ret;
>  
> -	assert(pmu->sysfs_aliases_loaded);
>  	list_for_each_entry(term, &terms->terms, list) {
>  		if (hwmon_pmu__config_term(hwm, attr, term, err))
>  			return -EINVAL;
> -- 
> 2.47.0.371.ga323438b13-goog
> 
