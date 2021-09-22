Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BDC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A669560F23
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhIVVBL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237905AbhIVVBL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632344380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gO65tY85mzxNSiMQSTLAVCO3OAT6edKTBG18pm5kxVg=;
        b=cFRcWeXN4q+qWV8r5+S87M5gY+09OCPtIP8qZT2UKVC0uh39apeMunq2LdHOn8lECERIV6
        HALK1D60F1TPqAQPNkoyLygqO+LF+48JLnrqxr0zV1KNSHLPqWQq4EsRfeHDjAI9djWjXq
        wCbrwLs35xRqdOjWbbOVYPR8YqXOyIQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-JKvdNaMRMHeMFFs-_78qbw-1; Wed, 22 Sep 2021 16:59:37 -0400
X-MC-Unique: JKvdNaMRMHeMFFs-_78qbw-1
Received: by mail-wr1-f70.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so3257038wrt.21
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gO65tY85mzxNSiMQSTLAVCO3OAT6edKTBG18pm5kxVg=;
        b=XJw64JSw5dELNUc7mbhi9TvFyKgmpTTBVXD70hGhCBhk2GnEQ5x1vbE30TYO594t+i
         Iiwsgtr3lFdMoUNkiMu0KOXBp6M+muxTCwffdHUvUHPCharV1Z8c0hN0JI1Jh5eV5Obp
         Mc5jphgK8yFGUG9XaDmsSBjBM5AWUj711rhF8ukEzNFZu1TKyF2LBE1Wogla9Fq9vi/d
         mSER+gfLkkEiMl2eLs8Lq8GC5TQcW21R9U+Jchfr8GutOjTsz1IVIguQQGrvLYroObtq
         zQXmSGRjzEUHL+xXZAhMZJZRZm8TrXCq6E73THm2phCDUfrxmquaRlvFpo/nUdY0SYax
         RArw==
X-Gm-Message-State: AOAM531EYdQcGP3WzcF04jHvAYm4j1hNH7ImaNOAKa2aaAG5P824vR5D
        NZGACcSvzZwLwcfl2GDXQ+TtWHVyuoX2mn6o6h3z0E6ftwahXtLl3fJgM/50Pz8/dFqecIG0rp7
        q2OYuGD26I8F8HtXFIVD4SbhszUbjJg==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr1173110wrc.30.1632344376668;
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAOX6zR8UdlJwxSo4byiE+o5OmKjpIEKhFgFNFvbI72YCtJS0RXQq3rDy0nRcqeTmyrwcK1Q==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr1173088wrc.30.1632344376488;
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c135sm7335517wme.6.2021.09.22.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:59:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v8 5/8] perf metric: Add utilities to work on ids map.
Message-ID: <YUuZNJjphZBHOAAA@krava>
References: <20210918063513.2356923-1-irogers@google.com>
 <20210918063513.2356923-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918063513.2356923-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 17, 2021 at 11:35:10PM -0700, Ian Rogers wrote:

SNIP

>  
> +struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
> +{
> +	size_t bkt;
> +	struct hashmap_entry *cur;
> +	int ret;
> +	struct expr_id_data *old_data = NULL;
> +	char *old_key = NULL;
> +
> +	if (!ids1)
> +		return ids2;
> +
> +	if (!ids2)
> +		return ids1;
> +
> +	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
> +		struct hashmap *tmp = ids1;
> +
> +		ids1 = ids2;
> +		ids2 = tmp;
> +	}
> +	hashmap__for_each_entry(ids2, cur, bkt) {
> +		ret = hashmap__set(ids1, cur->key, cur->value,
> +				(const void **)&old_key, (void **)&old_data);
> +		free(old_key);
> +		free(old_data);
> +
> +		if (ret)
> +			break;

should we return NULL in here?

jirka

> +	}
> +	hashmap__free(ids2);
> +	return ids1;
> +}
> +
> +/* Caller must make sure id is allocated */
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> +{
> +	return ids__insert(ctx->ids, id, ctx->parent);
> +}
> +

SNIP

