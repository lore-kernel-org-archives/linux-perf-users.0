Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2A7C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80C661027
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhJHKK0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 06:10:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhJHKKY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 06:10:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1B2D6E;
        Fri,  8 Oct 2021 03:08:29 -0700 (PDT)
Received: from [10.57.25.67] (unknown [10.57.25.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 928193F70D;
        Fri,  8 Oct 2021 03:08:26 -0700 (PDT)
Subject: Re: [PATCH 2/3] perf tools: Make the JSON parser more conformant when
 in strict mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, Nick.Forrington@arm.com,
        Andrew.Kilroy@arm.com, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-3-james.clark@arm.com> <YV8z306sBJQsdNNR@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <2e14963b-cb98-f508-7067-255fdbd36bdb@arm.com>
Date:   Fri, 8 Oct 2021 11:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV8z306sBJQsdNNR@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 07/10/2021 18:52, Jiri Olsa wrote:
> On Thu, Oct 07, 2021 at 12:05:41PM +0100, James Clark wrote:
>> Return an error when a trailing comma is found or a new item is
>> encountered before a comma or an opening brace. This ensures that the
>> perf json files conform more closely to the spec at https://www.json.org
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
>> index 11d1fa18bfa5..8124d2d3ff0c 100644
>> --- a/tools/perf/pmu-events/jsmn.c
>> +++ b/tools/perf/pmu-events/jsmn.c
>> @@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  	jsmnerr_t r;
>>  	int i;
>>  	jsmntok_t *token;
>> +#ifdef JSMN_STRICT
> 
> I might have missed some discussion on this, but do we need the
> JSMN_STRICT define, if you enable it in the next patch?
> why can't we be more strict by default.. do you plan to disable
> it in future?

I didn't plan on disabling it, I was just trying to keep to the existing style of the
jsmn project.

I could have added the trailing comma detection by default and not inside any
#ifdef JSMN_STRICT blocks, but I would like to enable JSMN_STRICT anyway, because it
enables some additional built in checking that was already there. So I thought it
made sense to put my new strict stuff inside the existing strict option.

One option would be to remove all (including the existing) #ifdef JSMN_STRICT blocks
and have everything strict by default. But it would be a further deviation from jsmn.

Thanks
James

> 
> thanks,
> jirka
> 
>> +	/*
>> +	 * Keeps track of whether a new object/list/primitive is expected. New items are only
>> +	 * allowed after an opening brace, comma or colon. A closing brace after a comma is not
>> +	 * valid JSON.
>> +	 */
>> +	int expecting_item = 1;
>> +#endif
>>  
>>  	for (; parser->pos < len; parser->pos++) {
>>  		char c;
>> @@ -185,6 +193,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  		switch (c) {
>>  		case '{':
>>  		case '[':
>> +#ifdef JSMN_STRICT
>> +			if (!expecting_item)
>> +				return JSMN_ERROR_INVAL;
>> +#endif
>>  			token = jsmn_alloc_token(parser, tokens, num_tokens);
>>  			if (token == NULL)
>>  				return JSMN_ERROR_NOMEM;
>> @@ -196,6 +208,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  			break;
>>  		case '}':
>>  		case ']':
>> +#ifdef JSMN_STRICT
>> +			if (expecting_item)
>> +				return JSMN_ERROR_INVAL;
>> +#endif
>>  			type = (c == '}' ? JSMN_OBJECT : JSMN_ARRAY);
>>  			for (i = parser->toknext - 1; i >= 0; i--) {
>>  				token = &tokens[i];
>> @@ -219,6 +235,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  			}
>>  			break;
>>  		case '\"':
>> +#ifdef JSMN_STRICT
>> +			if (!expecting_item)
>> +				return JSMN_ERROR_INVAL;
>> +			expecting_item = 0;
>> +#endif
>>  			r = jsmn_parse_string(parser, js, len, tokens,
>>  					      num_tokens);
>>  			if (r < 0)
>> @@ -229,11 +250,15 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  		case '\t':
>>  		case '\r':
>>  		case '\n':
>> -		case ':':
>> -		case ',':
>>  		case ' ':
>>  			break;
>>  #ifdef JSMN_STRICT
>> +		case ':':
>> +		case ',':
>> +			if (expecting_item)
>> +				return JSMN_ERROR_INVAL;
>> +			expecting_item = 1;
>> +			break;
>>  			/*
>>  			 * In strict mode primitives are:
>>  			 * numbers and booleans.
>> @@ -253,6 +278,9 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  		case 'f':
>>  		case 'n':
>>  #else
>> +		case ':':
>> +		case ',':
>> +			break;
>>  			/*
>>  			 * In non-strict mode every unquoted value
>>  			 * is a primitive.
>> @@ -260,6 +288,12 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  			/*FALL THROUGH */
>>  		default:
>>  #endif
>> +
>> +#ifdef JSMN_STRICT
>> +			if (!expecting_item)
>> +				return JSMN_ERROR_INVAL;
>> +			expecting_item = 0;
>> +#endif
>>  			r = jsmn_parse_primitive(parser, js, len, tokens,
>>  						 num_tokens);
>>  			if (r < 0)
>> @@ -282,7 +316,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>>  			return JSMN_ERROR_PART;
>>  	}
>>  
>> +#ifdef JSMN_STRICT
>> +	return expecting_item ? JSMN_ERROR_INVAL : JSMN_SUCCESS;
>> +#else
>>  	return JSMN_SUCCESS;
>> +#endif
>>  }
>>  
>>  /*
>> -- 
>> 2.28.0
>>
> 
