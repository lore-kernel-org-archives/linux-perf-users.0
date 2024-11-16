Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0C16419;
	Sat, 16 Nov 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785390; cv=none; b=OcgI5/FxOcp/CLtbkT3xiMk2cjULi5es0ruwzqelAy7lmU6xMIhhDADCOt/pvFmTPYsDYndZbCWHYnbu3SEy0cXRkx0HM9WDH9rqbAxWPoM3GD5MC4QI5TG9WuQunXq/Y7XIjN48pxm8ae0ditfiHamJElucLGzdPEXthtMnnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785390; c=relaxed/simple;
	bh=u0RZIVrvznZi+4W+LBM19VI/zwLffXOGblAB2DMKMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwadtWjvKzs/F+tXvEdwqPJMR8+eYlx6eb2xWGp9bQwcZAHRJx04Cp4fERv7Xrfl5MCyVho2gNZdaYicAQDQ5Yo8Xown0Xz29wWmurof6R30Bw05xAPrXPqULkVOn4phonK2Sz6KTAyQK1L7iaNrJdNcHLBJg9FXMLda3mGp84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOwsnIUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOwsnIUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8387C4CEC3;
	Sat, 16 Nov 2024 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731785389;
	bh=u0RZIVrvznZi+4W+LBM19VI/zwLffXOGblAB2DMKMSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOwsnIUZP6sjFdOreqMwIwai0AnW2t20C/hY5RzsmvO7sWJTqiQwW6Vtl540vxnxS
	 a3beASeKF0z+MadWyHUtuI5Kaj/BuotqdUJBnQArTvoL9Glmo/cEGH4ZLT8TjfnqCx
	 3ETPdaOw158bCRgnkle/nsjvlGaT5KUdjJDWvOXDlXn7FfGME+K/rcCSKneghiFKaK
	 RGShQnfhpED/4LGliZHMYvT5oW2pAQhePDVDP196/tculGGP/lRhgPTWiEE5r2LQxU
	 wDoupV76Yab7eRWvYztgO88hcMuwTDh92jJb+CrQ7n7aA7G2WzmnkJBLMgiYrwNT5Y
	 IgH8zJp/62SuQ==
Date: Sat, 16 Nov 2024 16:29:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Add missing __exit calls in tool/hwmon
 tests
Message-ID: <ZzjyqGH_tAzJh7vz@x1>
References: <20241115201258.509477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115201258.509477-1-irogers@google.com>

On Fri, Nov 15, 2024 at 12:12:58PM -0800, Ian Rogers wrote:
> Address sanitizer flagged the missing parse_events_error__exit when
> testing on ARM.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/hwmon_pmu.c | 1 +
>  tools/perf/tests/tool_pmu.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index 5c4114354c65..9f44093f18df 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -194,6 +194,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
>  	}
>  
>  out:
> +	parse_events_error__exit(&err);
>  	evlist__delete(evlist);
>  	return ret;
>  }
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 46896b485abf..187942b749b7 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -66,6 +66,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
>  	}
>  
>  out:
> +	parse_events_error__exit(&err);
>  	evlist__delete(evlist);
>  	return ret;
>  }
> -- 
> 2.47.0.338.g60cca15819-goog
