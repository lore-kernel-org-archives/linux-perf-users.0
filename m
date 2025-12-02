Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46E214A64;
	Tue,  2 Dec 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670562; cv=none; b=X2A96oKdsBZKMAuHQmRlO4oxpA0y6ko2/JSSSktGK2tmzYoJTyED6ykO7p9bQI8mcr/G1a6q3l03iO5+ur0FlESbOd1qs6HQJ5A21IAV90TFfsyo+DLD6O1nl120HJ112L1OnAXLObV7fBQjd54WOGbFOmqBl/bj8yv/tXDrBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670562; c=relaxed/simple;
	bh=Jn07b+OHkkgikm7s8lxh5Hyn2ya9deH1ZnyXoO09uoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaqZ5eQTdGkbA6tBxl3qOVyuMbDwJJRGicy+UtljuVsc/dCgUzWAfq+HLaRnR8usA8xBu46osRT8BddnKxdPZQ6Y+WyiQ3u4hWEkNP2WoYi4BQI1BTSwPhy/lbrgYx7Sxqe/U1A8CbjTazH9AZhI102wUzfF5ToJN6FEHaLQk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9EF4153B;
	Tue,  2 Dec 2025 02:15:51 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E8E3F73B;
	Tue,  2 Dec 2025 02:15:58 -0800 (PST)
Date: Tue, 2 Dec 2025 10:15:56 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] perf tools: Track all user changed config bits
Message-ID: <20251202101556.GR724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-1-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-james-perf-config-bits-v1-1-22ecbbf8007c@linaro.org>

On Mon, Dec 01, 2025 at 04:41:04PM +0000, Coresight ML wrote:

[...]

> +#define ADD_CONFIG_CHG(format_type, term_type, new_term)		\
> +{									\
> +	struct parse_events_term *term;					\
> +	u64 bits = 0;							\
> +	int type;							\
> +									\
> +	list_for_each_entry(term, &head_config->terms, list) {		\
> +		if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {  \
> +			type = perf_pmu__format_type(pmu, term->config);\
> +			if (type != format_type)			\
> +				continue;				\
> +			bits |= perf_pmu__format_bits(pmu, term->config); \
> +		} else if (term->type_term == term_type) {		\
> +			bits = ~(u64)0;					\
> +		}							\
> +	}								\
> +									\
> +	if (bits)							\
> +		ADD_CONFIG_TERM_VAL(new_term, cfg_chg, bits, false);	\
> +	return 0;							\

Nitpick: "return 0" is not needed here.  Otherwise:

Reviewed-by: Leo Yan <leo.yan@arm.com>
