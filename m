Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A681D9346
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284514; cv=none; b=M4j5WtU3BOMkJIBpV10i/mqkS2DfaSGzGOXYa7I1FWajC0bwcbJDNPNKEbNtV4EAz4D8f9DubfeJd9OQ8dPRC2mVWaz5LTO1Uyatscg9TQybpRkNAFV2lhya+8fx/gT5GbAhNBeY4oCiEwgGXSu1G7OwAgl39lUGjJWJ/h0+CIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284514; c=relaxed/simple;
	bh=ipawvU10MeY0/F4QmO1nBcRJaSyI8ful751IjqKxV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3k5TnZI0QLrNmKw7uUxHWsbVtXFaYb01jmkX4u/Iw+MTGwkhaiUFSlJ5uk7jYXuyLzrzz/M0R60YpkHksfn/9BSOucHcTaGzrPY+tKWrOdeld8vpSu0tFDX6Jv/Qe+Oo8ForuG/8OKZxm+FmZcnVSyLSLs1yf65Vj5Z3JedMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zLjK3Y1t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLjK3Y1t"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a1c28778so71087965e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765284511; x=1765889311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHHLz1RLwGhRDW3I6vWs3gc+AOBl/KmAdildvKxDrHU=;
        b=zLjK3Y1tbSUUSFzXgmkd9gjIjS+Xs82EFlkDvstcsifK4voRM1r1MwVjCf3Xr0QRDQ
         /idsfe5Ia5TpTFWdExczedV9zkiRxv82l/3IQN8WodnqmiEx+104UGeVzPmkBfhpJFQB
         9VKIC8+tkr/xXOr7BnDfQa/qUHGEggKD3GP+N2l6MHUP0STm4w+iCjQfbLj4oVybwYEe
         yvIphOCLBaFhfkyNlb9GrJNQ4K80tet5/GnkN8rXJjNprQJR9oZjiaWlHdcRgU2tvcdi
         X844j8xVtPw3x7XjsLAQHl3RoMl/fpLCdXPjOBMvnZNv80rDv/vlwEuUWyPA5oHgRrIX
         lvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765284511; x=1765889311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHHLz1RLwGhRDW3I6vWs3gc+AOBl/KmAdildvKxDrHU=;
        b=c7EEa9XHiHDallABzSp8KQPvEFlr95Jiei45KFWkyKtPYbO4ImqVPjyKCQ45ZX2xMD
         fUwUm9Z3CLgAMqfMl6jcwgz2uefpgiBvXAeo8gXG5NIQ80Kr+7VW+h7Dn3hHeCWG9uRo
         8lAIULolPCRK8NFLcYGzrnpqNSqQlb3Ri3Lkw07bRvw1zPCWSKbX2sYAca7jKCegGoYR
         /77gBux3tQSO9LeD7zAIu/meZZnp0Lf8Nobx5AyBsDg0As6ZvFlD0xFKSAs8aFpDC0Si
         zsiXl0BgxOZtKa9wjDnWpOtr41fXkI8tOtu4fwjj8xrMH884TD9VnJdJMppLiNw92jLs
         6oCw==
X-Gm-Message-State: AOJu0Yy1ruttJdiFYxbwm0zmo4hgObb6jP2nqku5pL8nYs4s5nIWHuNW
	mrwYeX1Vxphbh5byiMzfaOzKnxMR9r7rUeXFx05xGEUgN+FR8C9MVw6jBXywIMLp+2hH4lgPbWK
	AeZ+bLgY=
X-Gm-Gg: ASbGncsuTZ/ZGSNSJNmOrYePmeDMa9cgl63IQVmzkrm+mmS500CnV1tHdPpScSmpCeg
	FggRRIlT1lvW/MXbkQPBEWixUurlrNXRLz1AT/Q3Rqqb2Jn4JyySp4Kezy0weVOE3zWIGbkG5c5
	z89owbGkUJ9300n/ZHyJKG0l+cgktsI42GQ8bcbPUuc0o2EI/62P+1ZlamXU4z1KSXPD+wnA6jr
	zr+w9gtVxNZHCrCS1EjJc+rbMvcpSRQckkTO1BO/6f8yVWQMsnJGYI2gJJAqRMTwztt5ZKKKIxe
	eqocAU4+fB1aEfwcLmZOWAwdlB+olV/TBWdRvDloAq4+Zl7yxFivOqdQi1qtt6mhdW2G/lSad3O
	/MrTrsMJru8S+6TP3YIHqD+VZazUKMVkj9wuNA3uVOdZOE8pMSdgs4qceytUjFaTP9K07ctsTPc
	BGnV1iHxhsF1ZsEfTM
X-Google-Smtp-Source: AGHT+IH/tQGmS6GHJ3t67HVfHiCgCGjoF1ojSeipg6AskG+8k553iiIIAwskXFnSZzNHJohzxVNrTA==
X-Received: by 2002:a05:600c:4e14:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47939e2b900mr105471285e9.25.1765284510892;
        Tue, 09 Dec 2025 04:48:30 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d352a52sm31770665f8f.38.2025.12.09.04.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 04:48:30 -0800 (PST)
Message-ID: <6ba6bde3-f56b-4354-b336-4739cb1edb71@linaro.org>
Date: Tue, 9 Dec 2025 12:48:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] perf parse-events: Refactor get_config_terms()
 to remove macros
To: Linux perf Profiling <linux-perf-users@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
 <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/12/2025 2:22 pm, James Clark wrote:
> The ADD_CONFIG_TERM() macros build the __type argument out of a partial
> EVSEL__CONFIG_TERM_x enum name. This means that they can't be called
> from a function where __type is a variable and it's also impossible to
> grep the codebase to find usages of these enums as they're never typed
> in full.
> 
> Fix this by removing the macros and replacing them with an
> add_config_term() function. It seems the main reason these existed in
> the first place was to avoid type punning and to write to a specific
> field in the union, but the same thing can be achieved with a single
> write to a u64 'val' field.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/util/evsel_config.h |   1 +
>   tools/perf/util/parse-events.c | 146 ++++++++++++++++++++++++-----------------
>   2 files changed, 86 insertions(+), 61 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index bcd3a978f0c4..685fd8d5c4a8 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -50,6 +50,7 @@ struct evsel_config_term {
>   		u64	      cfg_chg;
>   		char	      *str;
>   		int	      cpu;
> +		u64	      val;
>   	} val;
>   	bool weak;
>   };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 17c1c36a7bf9..d5b009b4ebab 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1116,105 +1116,107 @@ static int config_attr(struct perf_event_attr *attr,
>   	return 0;
>   }
>   
> -static int get_config_terms(const struct parse_events_terms *head_config,
> -			    struct list_head *head_terms)
> +static struct evsel_config_term *add_config_term(enum evsel_term_type type,
> +						 struct list_head *head_terms,
> +						 bool weak)
>   {
> -#define ADD_CONFIG_TERM(__type, __weak)				\
> -	struct evsel_config_term *__t;			\
> -								\
> -	__t = zalloc(sizeof(*__t));				\
> -	if (!__t)						\
> -		return -ENOMEM;					\
> -								\
> -	INIT_LIST_HEAD(&__t->list);				\
> -	__t->type       = EVSEL__CONFIG_TERM_ ## __type;	\
> -	__t->weak	= __weak;				\
> -	list_add_tail(&__t->list, head_terms)
> -
> -#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)	\
> -do {								\
> -	ADD_CONFIG_TERM(__type, __weak);			\
> -	__t->val.__name = __val;				\
> -} while (0)
> +	struct evsel_config_term *t;
>   
> -#define ADD_CONFIG_TERM_STR(__type, __val, __weak)		\
> -do {								\
> -	ADD_CONFIG_TERM(__type, __weak);			\
> -	__t->val.str = strdup(__val);				\
> -	if (!__t->val.str) {					\
> -		zfree(&__t);					\
> -		return -ENOMEM;					\
> -	}							\
> -	__t->free_str = true;					\
> -} while (0)
> +	t = zalloc(sizeof(*t));
> +	if (!t)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&t->list);
> +	t->type = type;
> +	t->weak	= weak;
> +	list_add_tail(&t->list, head_terms);
>   
> +	return t;
> +}
> +
> +static int get_config_terms(const struct parse_events_terms *head_config,
> +			    struct list_head *head_terms)
> +{
>   	struct parse_events_term *term;
>   
>   	list_for_each_entry(term, &head_config->terms, list) {
> +		struct evsel_config_term *new_term;
> +		enum evsel_term_type new_type;
> +		char *str = NULL;
> +		u64 val;
> +
>   		switch (term->type_term) {
>   		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_PERIOD;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_FREQ;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_TIME:
> -			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_TIME;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_CALLGRAPH;
> +			str = term->val.str;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -			ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_BRANCH;
> +			str = term->val.str;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
> -					    term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_STACK_USER;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> -					    term->val.num ? 1 : 0, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_INHERIT;
> +			val = term->val.num ? 1 : 0;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> -					    term->val.num ? 0 : 1, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_INHERIT;
> +			val = term->val.num ? 0 : 1;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
> -					    term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_MAX_STACK;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
> -					    term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_MAX_EVENTS;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> -					    term->val.num ? 1 : 0, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_OVERWRITE;
> +			val = term->val.num ? 1 : 0;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> -					    term->val.num ? 0 : 1, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_OVERWRITE;
> +			val = term->val.num ? 0 : 1;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_DRV_CFG;
> +			str = term->val.str;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -			ADD_CONFIG_TERM_VAL(PERCORE, percore,
> -					    term->val.num ? true : false, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_PERCORE;
> +			val = term->val.num ? true : false;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
> -					    term->val.num ? 1 : 0, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_AUX_OUTPUT;
> +			val = term->val.num ? 1 : 0;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
> -			ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_AUX_ACTION;
> +			str = term->val.str;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
> -					    term->val.num, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE;
> +			val = term->val.num;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> -			ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
> +			new_type = EVSEL__CONFIG_TERM_RATIO_TO_PREV;
> +			str = term->val.str;
>   			break;
>   		case PARSE_EVENTS__TERM_TYPE_USER:
>   		case PARSE_EVENTS__TERM_TYPE_CONFIG:
> @@ -1229,7 +1231,23 @@ do {								\
>   		case PARSE_EVENTS__TERM_TYPE_RAW:
>   		case PARSE_EVENTS__TERM_TYPE_CPU:
>   		default:
> -			break;
> +			/* Don't add a new term for these ones */
> +			continue;
> +		}
> +
> +		new_term = add_config_term(new_type, head_terms, term->weak);
> +		if (!new_term)
> +			return -ENOMEM;
> +
> +		if (str) {
> +			new_term->val.str = strdup(str);
> +			if (!new_term->val.str) {
> +				zfree(&new_term);
> +				return -ENOMEM;
> +			}
> +			new_term->free_str = true;
> +		} else {

This will incorrectly hit the else if term->val.str is NULL. Not sure if 
that can happen but will fix anyway.

> +			new_term->val.val = val;

There's an uninitialized variable warning for val here on release 
builds. Will fix too

>   		}
>   	}
>   	return 0;
> @@ -1290,10 +1308,16 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>   		}
>   	}
>   
> -	if (bits)
> -		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
> +	if (bits) {
> +		struct evsel_config_term *new_term;
> +
> +		new_term = add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
> +					   head_terms, false);
> +		if (!new_term)
> +			return -ENOMEM;
> +		new_term->val.cfg_chg = bits;
> +	}
>   
> -#undef ADD_CONFIG_TERM
>   	return 0;
>   }
>   
> 

