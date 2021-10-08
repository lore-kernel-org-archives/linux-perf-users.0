Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB4C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B1760F43
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhJHNOQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242429AbhJHNOQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 09:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633698740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WnYTeFX7lQqI8TAg+qtycd8pv7aRimkmtdXDeDpWrKI=;
        b=HlRSEVOYTsKKNZjDC66E/sDGTaLO000iq05fSsql6DT7oPZFLjCCNArfvJbJehvcs0s/i6
        GpLL4u3PzFDTH4eKYW+WmJmQM1tS1NdC0nEcszbNODKF1t0hZBMd6tOOqqGbo+nUoYiuD4
        VuZVsfyBT3XCPr94pFTWnHHk04R8WhY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-BJ1_F88MP6-TNHH5sZbYiQ-1; Fri, 08 Oct 2021 09:12:07 -0400
X-MC-Unique: BJ1_F88MP6-TNHH5sZbYiQ-1
Received: by mail-wr1-f70.google.com with SMTP id r16-20020adfbb10000000b00160958ed8acso7286913wrg.16
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Oct 2021 06:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnYTeFX7lQqI8TAg+qtycd8pv7aRimkmtdXDeDpWrKI=;
        b=pL66AlOmohIGIywjftnr0uaFestgkJv6MqxWLWxu6sIWF4OGvSjIsg05ZQ1DiDc3/i
         wjs36GP6n+Z1wxUadf3vYiJOdi8w1pCrT4tEEk623LT00K97uy4j7RLH8NhJS9/ltu9k
         DcNmJBWcuG1BZEVW8IB3uSYiX5jatyrheVqake9S3swuAlLgk0yoX7v0Q0LFlRGeoE+R
         bxuf6Y15rSc8K1aDE/Pm5YH6BTjb3VAgQkJqObVJj3VWxBOylEeYkOkMuvyjIR2rUh/w
         bQplqOgdHD6Z09o4xaQcbaRAOk8UkiTOnxO0d5IHIYb3QeBTqAS/6Up/+bCnYor3/AAe
         9V4A==
X-Gm-Message-State: AOAM533iF+c4pEwwnWsXQdEmrzAwaWH9cv6lnva04tBuThKdDl/jCRF0
        GNAPgode0PvfyadMjuStC00mdW86lx2Xbdf3MVJjt+ezYcwQOidi+YABYbQQXHP/x2fB2Ww/Vy4
        PPAV9x0Bo+gxnVuHfDYBlhJQ5N6iHfg==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3367819wmq.159.1633698725749;
        Fri, 08 Oct 2021 06:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCSO/Avnl4s1uQbwWoYbdYzpDTgr0ryONsaTkgBvKCfsjZ230gSR23hW1R7JgDYoCIz7QQig==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3367782wmq.159.1633698725546;
        Fri, 08 Oct 2021 06:12:05 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k17sm2494501wrq.7.2021.10.08.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:12:05 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:12:03 +0200
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
Message-ID: <YWBDo5Ciq1hOIxLq@krava>
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-3-james.clark@arm.com>
 <YV8z306sBJQsdNNR@krava>
 <2e14963b-cb98-f508-7067-255fdbd36bdb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e14963b-cb98-f508-7067-255fdbd36bdb@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 08, 2021 at 11:08:25AM +0100, James Clark wrote:
> 
> 
> On 07/10/2021 18:52, Jiri Olsa wrote:
> > On Thu, Oct 07, 2021 at 12:05:41PM +0100, James Clark wrote:
> >> Return an error when a trailing comma is found or a new item is
> >> encountered before a comma or an opening brace. This ensures that the
> >> perf json files conform more closely to the spec at https://www.json.org
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 40 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
> >> index 11d1fa18bfa5..8124d2d3ff0c 100644
> >> --- a/tools/perf/pmu-events/jsmn.c
> >> +++ b/tools/perf/pmu-events/jsmn.c
> >> @@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  	jsmnerr_t r;
> >>  	int i;
> >>  	jsmntok_t *token;
> >> +#ifdef JSMN_STRICT
> > 
> > I might have missed some discussion on this, but do we need the
> > JSMN_STRICT define, if you enable it in the next patch?
> > why can't we be more strict by default.. do you plan to disable
> > it in future?
> 
> I didn't plan on disabling it, I was just trying to keep to the existing style of the
> jsmn project.
> 
> I could have added the trailing comma detection by default and not inside any
> #ifdef JSMN_STRICT blocks, but I would like to enable JSMN_STRICT anyway, because it
> enables some additional built in checking that was already there. So I thought it
> made sense to put my new strict stuff inside the existing strict option.
> 
> One option would be to remove all (including the existing) #ifdef JSMN_STRICT blocks
> and have everything strict by default. But it would be a further deviation from jsmn.

ok, I think it makes sense to have JSMN_STRICT then..
thanks for explanation

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
> Thanks
> James
> 
> > 
> > thanks,
> > jirka
> > 
> >> +	/*
> >> +	 * Keeps track of whether a new object/list/primitive is expected. New items are only
> >> +	 * allowed after an opening brace, comma or colon. A closing brace after a comma is not
> >> +	 * valid JSON.
> >> +	 */
> >> +	int expecting_item = 1;
> >> +#endif
> >>  
> >>  	for (; parser->pos < len; parser->pos++) {
> >>  		char c;
> >> @@ -185,6 +193,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  		switch (c) {
> >>  		case '{':
> >>  		case '[':
> >> +#ifdef JSMN_STRICT
> >> +			if (!expecting_item)
> >> +				return JSMN_ERROR_INVAL;
> >> +#endif
> >>  			token = jsmn_alloc_token(parser, tokens, num_tokens);
> >>  			if (token == NULL)
> >>  				return JSMN_ERROR_NOMEM;
> >> @@ -196,6 +208,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  			break;
> >>  		case '}':
> >>  		case ']':
> >> +#ifdef JSMN_STRICT
> >> +			if (expecting_item)
> >> +				return JSMN_ERROR_INVAL;
> >> +#endif
> >>  			type = (c == '}' ? JSMN_OBJECT : JSMN_ARRAY);
> >>  			for (i = parser->toknext - 1; i >= 0; i--) {
> >>  				token = &tokens[i];
> >> @@ -219,6 +235,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  			}
> >>  			break;
> >>  		case '\"':
> >> +#ifdef JSMN_STRICT
> >> +			if (!expecting_item)
> >> +				return JSMN_ERROR_INVAL;
> >> +			expecting_item = 0;
> >> +#endif
> >>  			r = jsmn_parse_string(parser, js, len, tokens,
> >>  					      num_tokens);
> >>  			if (r < 0)
> >> @@ -229,11 +250,15 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  		case '\t':
> >>  		case '\r':
> >>  		case '\n':
> >> -		case ':':
> >> -		case ',':
> >>  		case ' ':
> >>  			break;
> >>  #ifdef JSMN_STRICT
> >> +		case ':':
> >> +		case ',':
> >> +			if (expecting_item)
> >> +				return JSMN_ERROR_INVAL;
> >> +			expecting_item = 1;
> >> +			break;
> >>  			/*
> >>  			 * In strict mode primitives are:
> >>  			 * numbers and booleans.
> >> @@ -253,6 +278,9 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  		case 'f':
> >>  		case 'n':
> >>  #else
> >> +		case ':':
> >> +		case ',':
> >> +			break;
> >>  			/*
> >>  			 * In non-strict mode every unquoted value
> >>  			 * is a primitive.
> >> @@ -260,6 +288,12 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  			/*FALL THROUGH */
> >>  		default:
> >>  #endif
> >> +
> >> +#ifdef JSMN_STRICT
> >> +			if (!expecting_item)
> >> +				return JSMN_ERROR_INVAL;
> >> +			expecting_item = 0;
> >> +#endif
> >>  			r = jsmn_parse_primitive(parser, js, len, tokens,
> >>  						 num_tokens);
> >>  			if (r < 0)
> >> @@ -282,7 +316,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> >>  			return JSMN_ERROR_PART;
> >>  	}
> >>  
> >> +#ifdef JSMN_STRICT
> >> +	return expecting_item ? JSMN_ERROR_INVAL : JSMN_SUCCESS;
> >> +#else
> >>  	return JSMN_SUCCESS;
> >> +#endif
> >>  }
> >>  
> >>  /*
> >> -- 
> >> 2.28.0
> >>
> > 
> 

