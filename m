Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF575C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B272960F93
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhJHS60 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhJHS6Z (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 14:58:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B18360FE8;
        Fri,  8 Oct 2021 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719389;
        bh=hoAj05YuCRBBNrVjKODoIaxA5Jw6r/qy0A5fr49luFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTedW6HxC0PQ40Ac5yGvKfkbP3O0QVCmM7/uLPjf3kz7pPvtu3Tn0JzbD5y8bhzyL
         OpVn2YKBHxIAK/43QAmCq3xdT85kXHHV+G3xQjBsux4Rsj3CJ+wNFXlaurQTHLp5KI
         5BvpJqU0pwmisE0QhnjIRE1ClWiwQVLmsvJ0AFMRJvFzQRsCmuh7TstTC7u7xZ+mMX
         fHAYZsS7MsWiKifDBjBnMGBwXegLSl/g+FiIX8s5S1gd8fELcKv6j30aXbRaBfYvwl
         JLI6J6/pzmBssxupn6ZHssyJPL2UPt9i8c8S2UPRAWY12SjX0w6WPbit4I+8f2Fcfp
         JbmYaR8uTTNJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D609B410A1; Fri,  8 Oct 2021 15:56:26 -0300 (-03)
Date:   Fri, 8 Oct 2021 15:56:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     James Clark <james.clark@arm.com>, john.garry@huawei.com,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf tools: Make the JSON parser more conformant
 when in strict mode
Message-ID: <YWCUWo6pMns6p05o@kernel.org>
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-3-james.clark@arm.com>
 <YV8z306sBJQsdNNR@krava>
 <2e14963b-cb98-f508-7067-255fdbd36bdb@arm.com>
 <YWBDo5Ciq1hOIxLq@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWBDo5Ciq1hOIxLq@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 08, 2021 at 03:12:03PM +0200, Jiri Olsa escreveu:
> On Fri, Oct 08, 2021 at 11:08:25AM +0100, James Clark wrote:
> > 
> > 
> > On 07/10/2021 18:52, Jiri Olsa wrote:
> > > On Thu, Oct 07, 2021 at 12:05:41PM +0100, James Clark wrote:
> > >> Return an error when a trailing comma is found or a new item is
> > >> encountered before a comma or an opening brace. This ensures that the
> > >> perf json files conform more closely to the spec at https://www.json.org
> > >>
> > >> Signed-off-by: James Clark <james.clark@arm.com>
> > >> ---
> > >>  tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
> > >>  1 file changed, 40 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
> > >> index 11d1fa18bfa5..8124d2d3ff0c 100644
> > >> --- a/tools/perf/pmu-events/jsmn.c
> > >> +++ b/tools/perf/pmu-events/jsmn.c
> > >> @@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  	jsmnerr_t r;
> > >>  	int i;
> > >>  	jsmntok_t *token;
> > >> +#ifdef JSMN_STRICT
> > > 
> > > I might have missed some discussion on this, but do we need the
> > > JSMN_STRICT define, if you enable it in the next patch?
> > > why can't we be more strict by default.. do you plan to disable
> > > it in future?
> > 
> > I didn't plan on disabling it, I was just trying to keep to the existing style of the
> > jsmn project.
> > 
> > I could have added the trailing comma detection by default and not inside any
> > #ifdef JSMN_STRICT blocks, but I would like to enable JSMN_STRICT anyway, because it
> > enables some additional built in checking that was already there. So I thought it
> > made sense to put my new strict stuff inside the existing strict option.
> > 
> > One option would be to remove all (including the existing) #ifdef JSMN_STRICT blocks
> > and have everything strict by default. But it would be a further deviation from jsmn.
> 
> ok, I think it makes sense to have JSMN_STRICT then..
> thanks for explanation
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

So, is this for the whole patchset? b4 picked it just for this message.

- Arnaldo
 
> jirka
> 
> > 
> > Thanks
> > James
> > 
> > > 
> > > thanks,
> > > jirka
> > > 
> > >> +	/*
> > >> +	 * Keeps track of whether a new object/list/primitive is expected. New items are only
> > >> +	 * allowed after an opening brace, comma or colon. A closing brace after a comma is not
> > >> +	 * valid JSON.
> > >> +	 */
> > >> +	int expecting_item = 1;
> > >> +#endif
> > >>  
> > >>  	for (; parser->pos < len; parser->pos++) {
> > >>  		char c;
> > >> @@ -185,6 +193,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  		switch (c) {
> > >>  		case '{':
> > >>  		case '[':
> > >> +#ifdef JSMN_STRICT
> > >> +			if (!expecting_item)
> > >> +				return JSMN_ERROR_INVAL;
> > >> +#endif
> > >>  			token = jsmn_alloc_token(parser, tokens, num_tokens);
> > >>  			if (token == NULL)
> > >>  				return JSMN_ERROR_NOMEM;
> > >> @@ -196,6 +208,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  			break;
> > >>  		case '}':
> > >>  		case ']':
> > >> +#ifdef JSMN_STRICT
> > >> +			if (expecting_item)
> > >> +				return JSMN_ERROR_INVAL;
> > >> +#endif
> > >>  			type = (c == '}' ? JSMN_OBJECT : JSMN_ARRAY);
> > >>  			for (i = parser->toknext - 1; i >= 0; i--) {
> > >>  				token = &tokens[i];
> > >> @@ -219,6 +235,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  			}
> > >>  			break;
> > >>  		case '\"':
> > >> +#ifdef JSMN_STRICT
> > >> +			if (!expecting_item)
> > >> +				return JSMN_ERROR_INVAL;
> > >> +			expecting_item = 0;
> > >> +#endif
> > >>  			r = jsmn_parse_string(parser, js, len, tokens,
> > >>  					      num_tokens);
> > >>  			if (r < 0)
> > >> @@ -229,11 +250,15 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  		case '\t':
> > >>  		case '\r':
> > >>  		case '\n':
> > >> -		case ':':
> > >> -		case ',':
> > >>  		case ' ':
> > >>  			break;
> > >>  #ifdef JSMN_STRICT
> > >> +		case ':':
> > >> +		case ',':
> > >> +			if (expecting_item)
> > >> +				return JSMN_ERROR_INVAL;
> > >> +			expecting_item = 1;
> > >> +			break;
> > >>  			/*
> > >>  			 * In strict mode primitives are:
> > >>  			 * numbers and booleans.
> > >> @@ -253,6 +278,9 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  		case 'f':
> > >>  		case 'n':
> > >>  #else
> > >> +		case ':':
> > >> +		case ',':
> > >> +			break;
> > >>  			/*
> > >>  			 * In non-strict mode every unquoted value
> > >>  			 * is a primitive.
> > >> @@ -260,6 +288,12 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  			/*FALL THROUGH */
> > >>  		default:
> > >>  #endif
> > >> +
> > >> +#ifdef JSMN_STRICT
> > >> +			if (!expecting_item)
> > >> +				return JSMN_ERROR_INVAL;
> > >> +			expecting_item = 0;
> > >> +#endif
> > >>  			r = jsmn_parse_primitive(parser, js, len, tokens,
> > >>  						 num_tokens);
> > >>  			if (r < 0)
> > >> @@ -282,7 +316,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > >>  			return JSMN_ERROR_PART;
> > >>  	}
> > >>  
> > >> +#ifdef JSMN_STRICT
> > >> +	return expecting_item ? JSMN_ERROR_INVAL : JSMN_SUCCESS;
> > >> +#else
> > >>  	return JSMN_SUCCESS;
> > >> +#endif
> > >>  }
> > >>  
> > >>  /*
> > >> -- 
> > >> 2.28.0
> > >>
> > > 
> > 

-- 

- Arnaldo
