Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F837A3BB;
	Thu, 30 Oct 2025 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803221; cv=none; b=MP67XT4qo56RLISxcV56TwQ+2YZrjGsvSg3eJZ+05buspXHubsRfyXA8LaTNNh+JrqP/czPy0DGurt4wXpOVerV5KhslG++RAr9qYpHSaNTXM9ZLzwSsJXcmz666DVfrp3OjRGFfZjXJo/yKTSNPqA+0FpnE5fASRopRpMJX4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803221; c=relaxed/simple;
	bh=G+Ji/wAtkK2VXrXK/TPWjSMQTXNUNbkZgTV0hBZ1Iv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE93u8lHDk8JgdAaa5gPNrpt0I9q5U5AJ2eWcJ/y+dJAntGvNuLL5NMZ84dj2lBnRJYItRxhTOiPBed0GElhzyxCK0YYp9oNxnEgXCClJGe6+r278synfDQ5BDDCUFD4FzFlco5bBCCljdHwBx19VRisncZwq0llNXKCxrBvrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9agkIeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9agkIeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C694C4CEF1;
	Thu, 30 Oct 2025 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761803220;
	bh=G+Ji/wAtkK2VXrXK/TPWjSMQTXNUNbkZgTV0hBZ1Iv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9agkIeDywN7X0/n8zZG7U6xnZJzXTIFYvCqzzMS4BgqWuUStb2ymns3fpWJWzk8Y
	 dIEh8Ksg8nMZmiaTZiyI5hLM/qwcvLs3ZgDMSCSCMMKmfWcZpdpjltnug9OpPVEo2x
	 lDbqyqwJ7Pw+rRYwexMPZuBxe7ygNgq/VODuPqkh54Z+lR4V3ix6m8st/TX4wZTBqy
	 8aNFPUgQBKcWstlV92XRLm5MMOOK26m/Lb2oP21hxoRU79iFDDBaCDq9kdNZ941tPD
	 sHiXP3dc6h7+uio5b6xVZviGcPcDn0fAQmQERa3ermbR+n/mErAosjhDhy7aN1BUYK
	 Pj/DzSF9VrvRg==
Date: Wed, 29 Oct 2025 22:46:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf pmu: Make pmu_alias_terms weak again
Message-ID: <aQL70qlYohRT7cT8@google.com>
References: <20251029222638.816100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029222638.816100-1-irogers@google.com>

Hi Ian,

On Wed, Oct 29, 2025 at 03:26:37PM -0700, Ian Rogers wrote:
> The terms for a json event should be weak so they don't override
> command line options.

Can you please give an example command line and the error?

Thanks,
Namhyung

> 
> Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d597263fab4f..f14f2a12d061 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
>  static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
>  {
>  	struct parse_events_terms alias_terms;
> +	struct parse_events_term *term;
>  	int ret;
>  
>  	parse_events_terms__init(&alias_terms);
> @@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
>  		parse_events_terms__exit(&alias_terms);
>  		return ret;
>  	}
> +	list_for_each_entry(term, &alias_terms.terms, list) {
> +		/*
> +		 * Weak terms don't override command line options,
> +		 * which we don't want for implicit terms in aliases.
> +		 */
> +		term->weak = true;
> +	}
>  	list_splice_init(&alias_terms.terms, terms);
>  	parse_events_terms__exit(&alias_terms);
>  	return 0;
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 
