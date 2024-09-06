Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF431CE707;
	Fri,  6 Sep 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630481; cv=none; b=UMebDOiQdNz9hG7lp9G+C73OErMKPIM1Uqbr5mTrk3pNSuIblXajbNUV3G533cAffElCl2tymvDJEA/8f7p0VmlOtd0g3//QM17Tl4OP1okCw7SfIZJyeN2cssOUfV/bE6BqH+tEpSdeyv+NmeWG7AI0/nL27Icq9jT4nItgtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630481; c=relaxed/simple;
	bh=+8O4pLtD7OCQtBNgOU/P5tr0MQ0TvVJU1QDzGhpSrLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkLXB7fD8Gms0poDyBNP7GCCpWcz3EXizRzw45xIpkknakiw8e208IaVurPLlT3j7qsWN+WOWUS6vMSpijR5Q0qyyJRlPuGipDB+d0KfdUYHhz6NDxdeli6NGjnlRY0ZEMuR4u6EQ1HjVs6VA/v72R+UqgEBiVWDSiYpumwIxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQRRtaKO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQRRtaKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725630478; x=1757166478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+8O4pLtD7OCQtBNgOU/P5tr0MQ0TvVJU1QDzGhpSrLY=;
  b=bQRRtaKOf6sfz4CvRT16KzlPv0Z11q1DtBO80cYNB2v3A4YcYpAnZ1po
   6lTZkjrasCuJxffKAfGYrsQB6CANLIoyFwlVJrQhtgVsOMZMbh/NMq2Sz
   Z8w4enNgt35dQXl5Cd56fbmv+CdCzI10ZXZN5f6TSrQzi/O0BmtIoOYgV
   Q2hhw2xa+VHPMZp19M+meFFnZkkEzDH+X4p0P2oqIqo1k114tMVfx2Ce9
   7Zwqf7J2CAMrfEKtShcQRxZoYzYayErM/fzVyhDsn/kGawY1GiLjxX5Dn
   za8gx6y3NaOiuvwIvm+lFskFWDWdiYO7TSss5kRde/dfBUlU5vOrihUUX
   A==;
X-CSE-ConnectionGUID: tCAo1I4DRti7uM40J76Zcg==
X-CSE-MsgGUID: sb0qgOweS3+oFtzeWUdw0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35773403"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="35773403"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:47:56 -0700
X-CSE-ConnectionGUID: ngtMt1xQR6KpxAymjYN37g==
X-CSE-MsgGUID: ZlkD7W07TAuam7Q1nt187g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66503828"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:47:57 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4523C20B5782;
	Fri,  6 Sep 2024 06:47:54 -0700 (PDT)
Message-ID: <f171c2e5-3468-4cdb-b369-87e5aeb6660b@linux.intel.com>
Date: Fri, 6 Sep 2024 09:47:53 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] perf tools: Add fallback for exclude_guest
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>,
 James Clark <james.clark@linaro.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-2-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240905202426.2690105-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> changed to parse "cycles:P" event instead of creating a new cycles
> event for perf record.  But it also changed the way how modifiers are
> handled so it doesn't set the exclude_guest bit by default.
> 
> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
> if not.  Let's add a fallback so that it can work with default events.
> 
> Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  3 +--
>  tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index cf985cdb9a6ee588..d8315dae930184ba 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>  	 * (behavior changed with commit b0a873e).
>  	 */
>  	if (errno == EINVAL || errno == ENOSYS ||
> -	    errno == ENOENT || errno == EOPNOTSUPP ||
> -	    errno == ENXIO) {
> +	    errno == ENOENT || errno == ENXIO) {
>  		if (verbose > 0)
>  			ui__warning("%s event is not supported by the kernel.\n",
>  				    evsel__name(counter));

It seems the behavior for other reasons which trigger the 'EOPNOTSUPP'
is changed as well.
At least, it looks like we don't skip the member event with EOPNOTSUPP
anymore.

I'm not sure if it's a big deal. But I think we'd better mention it in
the change log or the comments.

Thanks,
Kan

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 49cc71511c0c8ce8..d59ad76b28758906 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3244,6 +3244,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>  		evsel->core.attr.exclude_kernel = 1;
>  		evsel->core.attr.exclude_hv     = 1;
>  
> +		return true;
> +	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
> +		   !evsel->exclude_GH) {
> +		const char *name = evsel__name(evsel);
> +		char *new_name;
> +		const char *sep = ":";
> +
> +		/* Is there already the separator in the name. */
> +		if (strchr(name, '/') ||
> +		    (strchr(name, ':') && !evsel->is_libpfm_event))
> +			sep = "";
> +
> +		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
> +			return false;
> +
> +		free(evsel->name);
> +		evsel->name = new_name;
> +		/* Apple M1 requires exclude_guest */
> +		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
> +		evsel->core.attr.exclude_guest = 1;
> +
>  		return true;
>  	}
>  
