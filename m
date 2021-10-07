Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6EC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6B361278
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbhJGRya (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241295AbhJGRy3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633629155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/dsIuaKlO7pigWC2XFT9YnQW2ugtzsHND9Ch5Tt4n8=;
        b=By0UO2GxWtxfiDOv/cblKGeI/5CnHBy+dDLm8W9G9HsEDMUkKNzLEW8CqBXdrpqsNUjUIO
        yNZk47mFgGqbuyeLUx09Wni1UkAFFRoloDpQUiZsfjZzqRLh9ibvqRIaMh+StlxrsBk8rk
        aQIQEu3SOasaSbSKQahunTtW5jqs4YI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-PJtiuBzQOuuqF3Tn_GX7TA-1; Thu, 07 Oct 2021 13:52:34 -0400
X-MC-Unique: PJtiuBzQOuuqF3Tn_GX7TA-1
Received: by mail-wr1-f69.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so5337235wrh.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/dsIuaKlO7pigWC2XFT9YnQW2ugtzsHND9Ch5Tt4n8=;
        b=QLy+aU/1rhnTl/Z5xYsD/7nvIXvq3xgReph8RdwhyBIO9YfBrcREWmY0K7HGWhcRkv
         Nbqmp7vtwlUIy0BgL0mz4sO9mwTo4aidydLdrcrG2ORyTSmdbAvRWKuJR0UfwVPVVwVf
         TQIe2DEO48XMEShJrqE0Ji3sdVA3TKr6/wE8ocZzw2en5mdkVZPIkCXiEk5AD0D8yKTt
         xL3b8D9LmMp86/aXQmnmXZjzvZRagDqemFn/1zckiTMrccZ9hUWsXRCyR8iAdmUhj3Du
         BJdmcuKbrXAfAeQ1qwLR1Ihnt4Hp3BY0A0oEz8wgrginrI5dC1zCU8zTkQCJsBOPCC8M
         8yng==
X-Gm-Message-State: AOAM531WtLRFvVdbaJ3MKZnbcip4FUWF06CTZTsvF6kRLsQWpI82W7cy
        UM7QKCzJQhJnkvmemefNwu2ov5Y1c28z0+j+GLtUnINpAMTFHD8YD3huALjF3qdUf9JKIh7MI2T
        mxlVq+immIiox2+urE5PT5ZnFPm1rcw==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr7351158wrs.404.1633629153525;
        Thu, 07 Oct 2021 10:52:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyafTyNDWiUOPlT/5I+U5kxCtR83TrjDrwOixohVCTrB5p8tURvUf7GmVjfKI+aNKTjjpo9YQ==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr7351125wrs.404.1633629153341;
        Thu, 07 Oct 2021 10:52:33 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id q16sm35192wrw.23.2021.10.07.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:52:33 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:52:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, Nick.Forrington@arm.com,
        Andrew.Kilroy@arm.com, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf tools: Make the JSON parser more conformant
 when in strict mode
Message-ID: <YV8z306sBJQsdNNR@krava>
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007110543.564963-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 07, 2021 at 12:05:41PM +0100, James Clark wrote:
> Return an error when a trailing comma is found or a new item is
> encountered before a comma or an opening brace. This ensures that the
> perf json files conform more closely to the spec at https://www.json.org
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
> index 11d1fa18bfa5..8124d2d3ff0c 100644
> --- a/tools/perf/pmu-events/jsmn.c
> +++ b/tools/perf/pmu-events/jsmn.c
> @@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  	jsmnerr_t r;
>  	int i;
>  	jsmntok_t *token;
> +#ifdef JSMN_STRICT

I might have missed some discussion on this, but do we need the
JSMN_STRICT define, if you enable it in the next patch?
why can't we be more strict by default.. do you plan to disable
it in future?

thanks,
jirka

> +	/*
> +	 * Keeps track of whether a new object/list/primitive is expected. New items are only
> +	 * allowed after an opening brace, comma or colon. A closing brace after a comma is not
> +	 * valid JSON.
> +	 */
> +	int expecting_item = 1;
> +#endif
>  
>  	for (; parser->pos < len; parser->pos++) {
>  		char c;
> @@ -185,6 +193,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  		switch (c) {
>  		case '{':
>  		case '[':
> +#ifdef JSMN_STRICT
> +			if (!expecting_item)
> +				return JSMN_ERROR_INVAL;
> +#endif
>  			token = jsmn_alloc_token(parser, tokens, num_tokens);
>  			if (token == NULL)
>  				return JSMN_ERROR_NOMEM;
> @@ -196,6 +208,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  			break;
>  		case '}':
>  		case ']':
> +#ifdef JSMN_STRICT
> +			if (expecting_item)
> +				return JSMN_ERROR_INVAL;
> +#endif
>  			type = (c == '}' ? JSMN_OBJECT : JSMN_ARRAY);
>  			for (i = parser->toknext - 1; i >= 0; i--) {
>  				token = &tokens[i];
> @@ -219,6 +235,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  			}
>  			break;
>  		case '\"':
> +#ifdef JSMN_STRICT
> +			if (!expecting_item)
> +				return JSMN_ERROR_INVAL;
> +			expecting_item = 0;
> +#endif
>  			r = jsmn_parse_string(parser, js, len, tokens,
>  					      num_tokens);
>  			if (r < 0)
> @@ -229,11 +250,15 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  		case '\t':
>  		case '\r':
>  		case '\n':
> -		case ':':
> -		case ',':
>  		case ' ':
>  			break;
>  #ifdef JSMN_STRICT
> +		case ':':
> +		case ',':
> +			if (expecting_item)
> +				return JSMN_ERROR_INVAL;
> +			expecting_item = 1;
> +			break;
>  			/*
>  			 * In strict mode primitives are:
>  			 * numbers and booleans.
> @@ -253,6 +278,9 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  		case 'f':
>  		case 'n':
>  #else
> +		case ':':
> +		case ',':
> +			break;
>  			/*
>  			 * In non-strict mode every unquoted value
>  			 * is a primitive.
> @@ -260,6 +288,12 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  			/*FALL THROUGH */
>  		default:
>  #endif
> +
> +#ifdef JSMN_STRICT
> +			if (!expecting_item)
> +				return JSMN_ERROR_INVAL;
> +			expecting_item = 0;
> +#endif
>  			r = jsmn_parse_primitive(parser, js, len, tokens,
>  						 num_tokens);
>  			if (r < 0)
> @@ -282,7 +316,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
>  			return JSMN_ERROR_PART;
>  	}
>  
> +#ifdef JSMN_STRICT
> +	return expecting_item ? JSMN_ERROR_INVAL : JSMN_SUCCESS;
> +#else
>  	return JSMN_SUCCESS;
> +#endif
>  }
>  
>  /*
> -- 
> 2.28.0
> 

