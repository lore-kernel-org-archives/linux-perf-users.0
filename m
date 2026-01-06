Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494C265CA2;
	Tue,  6 Jan 2026 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736562; cv=none; b=YjEWNRF3I3vb/F9sJ3hAyybmW3WJluPBdsJHIxibSKognx8ihD3ANUFIyPPIrJIBXM+FVvh+vw8kdcIuIG/kExcB7bKTHs1Yr/sTLRmKDg2P14LwmLTZn7oH6caQHgLoMcoytJqT5bd3DwjnC32tV6c+CKY4jdhBk1lxufXebpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736562; c=relaxed/simple;
	bh=x8Zl5EnX9jHrFuP8TXd1n9ZPuEnEv+xhzNWWBIJuAEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1/ewsR71Pct7GygICQk1Cz74iOFHid4vUp9oX2y75bzHHLL3moeeTDkgLeIT1HDxwaA1MjcMBAav8MEJxgU2ssFQ2q/wcOJz14MaowoHTpnrnnEWgdf7mNcoO4N1hTV3cXAv0ad8bUpWh1cIookqMOdY8Cgj+KWXcxSERvnPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot5DhWyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot5DhWyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E78C116C6;
	Tue,  6 Jan 2026 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767736561;
	bh=x8Zl5EnX9jHrFuP8TXd1n9ZPuEnEv+xhzNWWBIJuAEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot5DhWypdTBNoidAmpNZxAzB9YtXqkpRbGz/xeufZXIZa5f3VR0X3FAUqcWlodAqR
	 26JZSK4Yuh7Br+slGcKHXLybj7/whP7e+kX+Vm3ExCPyApbsz7TlRS4e8VfWO3QWby
	 VDevnWcBcuf4bnGtu6mqQtfClVL6HyWazIj3lSkKOKg/vKurA006MH+oDuJEPB7zjB
	 hRnQHCcKN84KT5Px226cJrOKozLC4eKOjmC+MjhPfbpJjuhCLr+RV2iXE+PYyN+yKh
	 e9l691TJSxvVey5G/PeM62iygd18TWpJpExy/qgMyQ4t6fa8ASK6WPif/smAvWVDL1
	 xmeiskWID7kYA==
Date: Tue, 6 Jan 2026 18:55:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Faisal Bukhari <faisalbukhari523@gmail.com>,
	Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Fix evsel allocation failure
Message-ID: <aV2E7e2Cim8v8Bjm@x1>
References: <20250922180834.1744399-1-faisalbukhari523@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922180834.1744399-1-faisalbukhari523@gmail.com>

On Mon, Sep 22, 2025 at 11:38:34PM +0530, Faisal Bukhari wrote:
> If evsel__new_idx() returns NULL, the function currently jumps 
> to label 'out_err'.
> Here, references to `cpus` and `pmu_cpus` are dropped.
> Also, resources held by evsel->name and evsel->metric_id are freed.
> But if evsel__new_idx() returns NULL, 
> it can lead to NULL pointer dereference.

You forgot to add:

Fixes: cd63c22168257a0b ("perf parse-events: Minor __add_event refactoring")

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Namhyung, I think this should go into v6.19-rc,

- Arnaldo
 
> Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
> ---
>  tools/perf/util/parse-events.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 452f12191f6e..02e7ff94a2d2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -286,8 +286,11 @@ __add_event(struct list_head *list, int *idx,
>  		event_attr_init(attr);
>  
>  	evsel = evsel__new_idx(attr, *idx);
> -	if (!evsel)
> -		goto out_err;
> +	if (!evsel) {
> +		perf_cpu_map__put(cpus);
> +		perf_cpu_map__put(pmu_cpus);
> +		return NULL;
> +	}
>  
>  	if (name) {
>  		evsel->name = strdup(name);
> -- 
> 2.43.0
