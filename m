Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B8C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A46560EDF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhIVVSb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236476AbhIVVSb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632345420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9XciI8CgY0oAFbvgg75jCc0JCEwmQ6YfL9zOXhGyA0=;
        b=KbrErJ8OPAC0JV0vt/8bZchdrC1AlcnlYCmv4auyHOmz0zvCZRnq5SHhSRWiwWnUWlgaoe
        OsVz3hMmFO0jUzOBoKqEJTqHp0SFgXrzLem3WkMU6/znpYzMbwcmxV3+FLQtEuN5Je7rZz
        Xv8TzHccwyZJUea1D4sliiX3w6BdJ6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-zvPxHyMfMByuW6PGUqPRHw-1; Wed, 22 Sep 2021 17:16:58 -0400
X-MC-Unique: zvPxHyMfMByuW6PGUqPRHw-1
Received: by mail-wr1-f70.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso3353686wra.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 14:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9XciI8CgY0oAFbvgg75jCc0JCEwmQ6YfL9zOXhGyA0=;
        b=qc6zNNmK9LNNSg/6IeHXg1lOYGNZPmo8r1N7bPQnuEKJkOTtWD1NkpcnfeleTwkvlU
         yFP0QlwPgF2GVTgQo1HOixsrPyF6tx0ybkhBWTgizvGPAyIqk78hREDC2Q6zaPwXFd3a
         i3ACtuVPSeRXAU3pBJjdR2iQK4qZ0uoWIelegDSJXHgrMBw25Xb2ilGduEXMTdl2VzD+
         4+8C4KIo2BXrvpDnM4hiZS4H537v/WB59KTEuFiAGDyeAOqGQezek6AxjobVPmYo/VRC
         9LYI2KJ3XI9QJc7A4Jb78tV2hMMTZbvCLZaN7EYkOcVXxk74/cOE4HyePISIYBvWFI17
         faMA==
X-Gm-Message-State: AOAM530HWeiipG4/cEnT0HmTfM2CL/vkOlok6cztncL2AWIV1LHLHwEY
        5L7Dzz8EvL6b8WsnlisX46sszSkz22QpCF9a2ddqWwgm58t7PhD8j5wbUYn5D5/QUVla1KJg0KY
        Z/dsW7OOAmpg6trdl7F9MSDgqHo7I4A==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr1265772wru.10.1632345417660;
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUGJW0fMuTnzblv8vg/e92wQMuWOfHeTBFuXBDxELdzgGMsmb5dwknTE/UAX4PyXCYg4r6tw==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr1265760wru.10.1632345417466;
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m29sm3370410wrb.89.2021.09.22.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:16:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf evlist: Remove group option.
Message-ID: <YUudR8ST7qGYdFQE@krava>
References: <20210921181349.199780-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921181349.199780-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021 at 11:13:49AM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 8feef3a05af7..9cd79513eebb 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1109,14 +1109,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
>  				   PyObject *args, PyObject *kwargs)
>  {
>  	struct evlist *evlist = &pevlist->evlist;
> -	int group = 0;
> -	static char *kwlist[] = { "group", NULL };
> -
> -	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
> -		return NULL;
> -
> -	if (group)
> -		evlist__set_leader(evlist);
>  
>  	if (evlist__open(evlist) < 0) {
>  		PyErr_SetFromErrno(PyExc_OSError);
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index bff669b615ee..9e694db7c7ee 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>  	bool use_comm_exec;
>  	bool sample_id = opts->sample_id;
>  
> -	/*
> -	 * Set the evsel leader links before we configure attributes,
> -	 * since some might depend on this info.
> -	 */
> -	if (opts->group)
> -		evlist__set_leader(evlist);
> -

I don't mind erasing that, but just curious if you're going
to add something which would clash with this? it does not
look too complex for the code.. but still, let's remove it
if it's in 'legacy mode' for this long ;-)

thanks,
jirka


>  	if (evlist->core.cpus->map[0] < 0)
>  		opts->no_inherit = true;
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 68f471d9a88b..d71dee9ce41c 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -13,7 +13,6 @@ struct option;
>  
>  struct record_opts {
>  	struct target target;
> -	bool	      group;
>  	bool	      inherit_stat;
>  	bool	      no_buffering;
>  	bool	      no_inherit;
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

