Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58501DED4B;
	Mon, 10 Mar 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640025; cv=none; b=aI5cEe1ZResRNzlUZYP+Cjdn1Zy9QIsU+88o5q6CR7moZa7/Z4hhza4Ck2ZsJgSUcVSmAjmkKtsxel6vmM39fxPFfSzUYZ+K/g+X/feZHR58tOMyckm3adEX2l2sVCqYbjj0swZAVNcSdUBesPuJH9SvNpkfBvWUXvE8mVm12fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640025; c=relaxed/simple;
	bh=A9JcAFLg7LIrSagO1s2xx6JEqd8Xa6VdLK+LOHobkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS5Zyc4EaIkuuzyBXCMHpnwEuv/LvwDPKbNNc169Gf5Z7jgUW2M+7GFLoslratAmKXxDCwJJFO6CWcVjvCNDkdXeiXZUetJsQtnN6/jfaHz35E3yq3vZxHfGDKEW+f0M1vAE7BOnf357+++JGoxzD/lZCWsC7oRHYrTcWdOhip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sw9qVRn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw9qVRn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D81C4CEE5;
	Mon, 10 Mar 2025 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640024;
	bh=A9JcAFLg7LIrSagO1s2xx6JEqd8Xa6VdLK+LOHobkuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sw9qVRn+XkwEA4ysm8oZ72FhwGa/JOaoxyC6brDaROWhbuyidFm41oakGCFj8SS9G
	 vx9/zxEp05mXzxBoxL7zNl46IPi0Lg5BSfGtPzxxH91xmItEZSprjlKXTaRlKDfdRx
	 hDmGRDsFbXqiA/yw9i5571dcbs/FB4kzXi9zgnDrFS1hvtKU1GdkoqyQpjlGeyUNJG
	 Q5FrNkeTIt6kKZrntFFdQSq7lIDQj0ERi+QEuvmoWdrrhfzpMZiBXNEX5rVUcLdQl6
	 RYo3furw2hV2K9UD80KCKic6gObCT909tWSoVxyNKmWIfvWsynYxMExvq1dj7HXDsp
	 3kV1H7atTKMsA==
Date: Mon, 10 Mar 2025 17:53:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 07/11] perf python: Update ungrouped evsel leader in
 clone
Message-ID: <Z89RVc4HuASuVVVv@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-8-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:04PM -0800, Ian Rogers wrote:
> evsels are cloned in the python code as they form part of the Python
> object pyrf_evsel. The cloning doesn't update the evsel's leader, do
> this for the case of an evsel being ungrouped.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 4a3015e7dc83..e244cc74f16d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1312,6 +1312,8 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
>  	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
>  
>  	evsel__clone(&pevsel->evsel, evsel);
> +	if (evsel__is_group_leader(evsel))
> +		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
>  	return (PyObject *)pevsel;
>  }
>  
> -- 
> 2.48.1.711.g2feabab25a-goog
