Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0A80027;
	Thu, 21 Nov 2024 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168306; cv=none; b=pT9JCYzvLUYDTBwLQkDFB5PtuHhNK3hk8fsvQ4bV9HAII0x7ubTgGEc4r8totXiq2jF71s/hDlM7TT2LZzUnEwdcJpj3GY5K5fkz9HEgSqtQThMxp9LXwUm6fEWpjZk0ioEGODTBHX4fU4K2Xvdxe8SZA2Go/PrrJQ6uHeyEj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168306; c=relaxed/simple;
	bh=DxQR1KU3nwgD5oqVrb9iLNpDjjvqkVgAJIiZ4WuSFeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSQWCbUenolCTsqxP6lRuQUQ7txrQoV95kCv5/zI07eeOpe7lVTAoX77Kwlvt1Rt09um5JKOXWDjgflmSCWnYR1+vOGp0CMlY4hiJEghioRX5pdWXOEO33rqqY6aNTAyZiWq8DRO7enksCAgdnccJ7b2hpofUjburwu5dvdjJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+zVwTyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+zVwTyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24947C4CECC;
	Thu, 21 Nov 2024 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732168305;
	bh=DxQR1KU3nwgD5oqVrb9iLNpDjjvqkVgAJIiZ4WuSFeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+zVwTyYHwsozbXhmyi+B4AduUkqK6IOqOoZXY7HIjfUToeMGUQLudCPx7xjWSIAA
	 xl/0nOw+IYiplx+Fo6bylmsENvaM14yKgt25iLVHP9lmbZmJQdqP0TSLnIzGM0Ek4n
	 Fn68QxklLjACwYJuXU57ALpP9hzVuIUvTHMtPch2OpLlGIRRgbavbl5t6aqD/KB7gT
	 rwK9ryUzvWsSocladRZPcwz0OR5KZOf2GmFKvsMlr39VaFlhr9xUBO8VB3uAGxh1Z8
	 2cps2JzpgJek8ja6y2h9gVgr/xI0SVcVC9fkZXPCgKSMiUhOvRV7+yr4AS0tI1PHQ2
	 spK4Sdte8BWhw==
Date: Wed, 20 Nov 2024 21:51:42 -0800
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
Subject: Re: [PATCH v1] perf hwmon_pmu: Ensure hwmon key union is zeroed
 before use
Message-ID: <Zz7Kbp_XIu9f02Xj@google.com>
References: <20241119230033.115369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119230033.115369-1-irogers@google.com>

On Tue, Nov 19, 2024 at 03:00:33PM -0800, Ian Rogers wrote:
> Non-zero values led to mismatches in testing. This was reproducible
> with -fsanitize=undefined.

It's sad the compiler didn't initialize all the members if it has
members with different size.

> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/Zzdtj0PEWEX3ATwL@x1/
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/hwmon_pmu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index ac2245acdc6d..4d9d6f405434 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -274,7 +274,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
>  		int number;
>  		enum hwmon_item item;
>  		bool alarm;
> -		union hwmon_pmu_event_key key = {};
> +		union hwmon_pmu_event_key key = { .type_and_num = 0 };
>  		struct hwmon_pmu_event_value *value;
>  
>  		if (ent->d_type != DT_REG)
> @@ -560,7 +560,7 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
>  	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
>  	enum hwmon_type type;
>  	int number;
> -	union hwmon_pmu_event_key key = {};
> +	union hwmon_pmu_event_key key = { .type_and_num = 0 };
>  	struct hashmap_entry *cur;
>  	size_t bkt;
>  
> @@ -623,10 +623,11 @@ static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
>  					return -EINVAL;
>  			} else {
>  				union hwmon_pmu_event_key key = {
> -					.type = type,
> -					.num = number,
> +					.type_and_num = 0,
>  				};
>  
> +				key.type = type;
> +				key.num = number;
>  				attr->config = key.type_and_num;
>  			}
>  			return 0;
> -- 
> 2.47.0.371.ga323438b13-goog
> 
