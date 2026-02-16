Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B713101BC
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251626; cv=none; b=fLIVLNByWaaUttm554Mv6aGp241/0ZfvWoZaQpmbZW45OTjIjdIOVLJTuq/FCD1O+JZoomb82EtIahn6u6MPLbTNwp0hO8xgzq0elBFyTGdQnnRaFm44FP6ukR4ibnnPDDHThNRxYbIOgIKpI2cRogDRUjzz8xkWsuc7XGyuKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251626; c=relaxed/simple;
	bh=rPUTAnHPdeqX9YHPt/UQx4jCrkdrGUDL58HGWAC39Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx1dStrQDqe/qPXRrynmDiC4O6vyJXyST8hyxC3h/0iGH570ktR5sgXxh2V7XczWC5fDtHRml5lPuh/p8sT0XQUfcD3RfkRbaopoeY4NX70RsEvSqZP5wsghIupEXWGLl/yANSFOByG8nacwkwR6oD5h6d8hBL6cjdwWCtrS8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0NS95mP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0NS95mP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so17396075e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251622; x=1771856422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI0abDjoXH12yXpjgx00HS4Kr5u5a9GKP4jRb96jhT4=;
        b=s0NS95mPk0hV08v2qWqPlU6zLV3hQRGMEXIql3e3d7OTHRjY6EvdgnuhfJcKg/8ppE
         xAg8utL6i//oaKeJDbRVpJZaiClHAxSG91A3s0VkCylfz1wQ7Vk6DZZoDoem7WVLmDdh
         Z+8gjUsGIDvViyoTHiJlRX7rDVET5H1QBZZZxF7lbDmwIEuMqTEHxC+M0a9fg1MvDX+R
         Ub0sFYGG8AzrU94PpnBznRi2ia1sj+bro9Id6gVnCBTCh9XV+9WPW5eM8cQHTCDajEhc
         uACT8tZioEZheor02puVBCRiM3XWqnbudhWX9wml/Kn5NfmiaYm8+FDTijPX8HppdyMv
         LtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251622; x=1771856422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI0abDjoXH12yXpjgx00HS4Kr5u5a9GKP4jRb96jhT4=;
        b=eFp8+VtQPuT2IHT5Pox84fMPdZ+ci8LRFN7ktlJNHWrnMGCOZxd+UNHAubwdj3Oxys
         6eCLYvXp2/jBdFPUsyTfFUhaHgTZdHA0lrEKD18aHOkG/sfgwaSO4OdHHFBBD6Y0XCKS
         lnjz1Xg7romCmaT6kuGjjlvolMN/WaGB7i2bPZnFax7+mJ3774Eb0qKxAZvXiR2oS4Ow
         vc4+PumTVvtXyZtLgInPZnAMYXH8M8wNoVofZKGJN8bKMQTFxsJeYC3SVu5tNIrKmTSs
         w89eX7iEL6m9b1HFHeNAG3dd3H+iqMyicpW2ym5KcXYG4v0Nl/MQQLWyjRFL0V51sCka
         lUtw==
X-Forwarded-Encrypted: i=1; AJvYcCVqv0KEwubICKGBrQL+9GNar059HQhTLQOcmZ7UUyfu0EH2jyvENp49MrmwbbL4nbD7VZ6XnV82DropHiiIrJtd@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8gDl7OQFIDar5UxoALtMaX22Ck+poWW1iOBkU8Oh6gjbIwJ4
	+3aLsRitR4MKirh2aIxgPBvyTmbbzfCKxKOehXdWhC8gXq14D6MMITB/Hovu0obJHr0=
X-Gm-Gg: AZuq6aLGzYLwMfvRCs6rZBplV1WMyCIg4ohNgF8VjuWJLlGCYZ6oLZhJVftVUSVjmhn
	2yonkqIXMmqS0S0fp5I7sggTJp4fqyKDHKTYRvyVnqePLql9AMCrrUQa/ACruJLQxlbHwj4MTgQ
	RYnItLYnsHWQPGnZWXwWp4KCOj7eRn98KXE6gz3xOHAkHs9I6se8gEiGPHTAafAeIEFQQ3WOHq4
	qT9TqxLzVpdYYyrnaV4tLW1DzREyLBwkGzbFzPU7YLYxVHv1gXjPmYdAQd5gvKSZ61TCoCy2iSI
	6K0jyJjWeJVQXJN5h1XdzUG458ZXLho5BwPMUM9XOYTxNGhzybb0xHPjUS7ZT1UpZ6n0kts4ZSW
	IHswBE4DV8gqLUV75KoOza4SZzYAOTl8fT+zXey++5BcWVgc3cSiw/dx1o8O511WxevSWj7A2TH
	QnHB2YvvRZYV5V6yzBNc93CqkouGih
X-Received: by 2002:a05:600c:529b:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483739fc4d0mr202466985e9.3.1771251621937;
        Mon, 16 Feb 2026 06:20:21 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48387ab1974sm76075795e9.3.2026.02.16.06.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:20:21 -0800 (PST)
Message-ID: <4565f331-6dd6-4be9-8e6c-e6b6a4a628b3@linaro.org>
Date: Mon, 16 Feb 2026 14:20:20 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260216131050.2581963-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260216131050.2581963-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/02/2026 1:10 pm, Thomas Richter wrote:
> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> due to a NULL dereference when the backward mmap path isn't enabled.
> 
> Reproducer:
>    # ./perf test -F 'Read backward ring buffer'
>    Segmentation fault (core dumped)
>    # uname -m
>    s390x
>    #
> 
> Root cause:
> get_config_terms() stores into evsel_config_term::val.val (u64) while later
> code reads boolean fields such as evsel_config_term::val.overwrite.
> On big-endian the 1-byte boolean is left-aligned, so writing
> evsel_config_term::val.val = 1 is read back as
> evsel_config_term::val.overwrite = 0,
> leaving backward mmap disabled and a NULL map being used.
> 
> Store values in the union member that matches the term type, e.g.:
>    /* for OVERWRITE */
>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
> to fix this. Improve add_config_term() and add two more parameters for
> string and value. add_config_term() now creates a complete node element
> of type evsel_config_term and handles all evsel_config_term::val union
> members.
> 
> Impact:
> Enables backward mmap on big-endian and prevents the crash.
> No change on little-endian.
> 
> Output after:
>   # ./perf test -Fv 44
>   --- start ---
>   Using CPUID IBM,9175,705,ME1,3.8,002f
>   mmap size 1052672B
>   mmap size 8192B
>   ---- end ----
>   44: Read backward ring buffer                         : Ok
>   #
> 
> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/parse-events.c | 96 ++++++++++++++++++++++++++++------
>   1 file changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b9efb296bba5..bd48435a3e13 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
>   
>   static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>   						 struct list_head *head_terms,
> -						 bool weak)
> +						 bool weak, char *str, u64 val)
>   {
>   	struct evsel_config_term *t;
>   
> @@ -1128,8 +1128,78 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>   	INIT_LIST_HEAD(&t->list);
>   	t->type = type;
>   	t->weak	= weak;
> +
> +	if (str) {
> +		t->val.str = strdup(str);
> +		if (!t->val.str) {
> +			zfree(&t);
> +			return NULL;
> +		}
> +		t->free_str = true;
> +	} else {
> +		t->val.val = val;
> +	}

You could drop this if/else and do each thing in the switch, then 
there's no need for the comments saying it's already done e.g.:

   case EVSEL__CONFIG_TERM_PERIOD
   case EVSEL__CONFIG_TERM_FREQ:
   case EVSEL__CONFIG_TERM_STACK_USER:
       t->val.val = val;
       break;

   case EVSEL__CONFIG_TERM_DRV_CFG:
   case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
   case EVSEL__CONFIG_TERM_AUX_ACTION:
       assert(str);
       t->val.str = strdup(str);
       if (!t->val.str) {
          zfree(&t);
          return NULL;
       }
       t->free_str = true;
       break;

> +
> +	switch (type) {
> +	case EVSEL__CONFIG_TERM_PERIOD:
> +		/* Union member type match, assignment above */
> +		break;
> +	case EVSEL__CONFIG_TERM_FREQ:
> +		/* Union member type match, assignment above */
> +		break;
> +	case EVSEL__CONFIG_TERM_TIME:
> +		t->val.time = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_STACK_USER:
> +		/* Union member type match, assignment above */
> +		break;
> +	case EVSEL__CONFIG_TERM_INHERIT:
> +		t->val.inherit = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_OVERWRITE:
> +		t->val.overwrite = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_MAX_STACK:
> +		t->val.max_stack = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_MAX_EVENTS:
> +		t->val.max_events = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_PERCORE:
> +		t->val.percore = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_OUTPUT:
> +		t->val.aux_output = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
> +		t->val.aux_sample_size = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_CALLGRAPH:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_BRANCH:
> +		/* Type is string, assigned above */

Minor nit: You can collapse all the ones with the same comments, same as 
you have done for EVSEL__CONFIG_TERM_USR_CHG_CONFIG*

> +		break;
> +	case EVSEL__CONFIG_TERM_DRV_CFG:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_ACTION:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> +		/* Union member type match, assignment above */
> +		break;
> +	default:

I get this with clang:

util/parse-events.c:1200:10: error: label at end of compound statement: 
expected statement
         default:

Other than that it looks correct.

> +	}
> +
>   	list_add_tail(&t->list, head_terms);
> -
>   	return t;
>   }
>   
> @@ -1234,20 +1304,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>   			continue;
>   		}
>   
> -		new_term = add_config_term(new_type, head_terms, term->weak);
> +		/*
> +		 * Note: Members evsel_config_term::val and
> +		 * parse_events_term::val are unions and endianness needs
> +		 * to be taken into account when changing such union members.
> +		 */
> +		new_term = add_config_term(new_type, head_terms, term->weak,
> +					   str_type ? term->val.str : NULL, val);
>   		if (!new_term)
>   			return -ENOMEM;
> -
> -		if (str_type) {
> -			new_term->val.str = strdup(term->val.str);
> -			if (!new_term->val.str) {
> -				zfree(&new_term);
> -				return -ENOMEM;
> -			}
> -			new_term->free_str = true;
> -		} else {
> -			new_term->val.val = val;
> -		}
>   	}
>   	return 0;
>   }
> @@ -1277,10 +1342,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
>   	if (bits) {
>   		struct evsel_config_term *new_term;
>   
> -		new_term = add_config_term(new_term_type, head_terms, false);
> +		new_term = add_config_term(new_term_type, head_terms, false, NULL, bits);
>   		if (!new_term)
>   			return -ENOMEM;
> -		new_term->val.cfg_chg = bits;
>   	}
>   
>   	return 0;

