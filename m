Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F303C61DD8
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA0522447
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHWLAU/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgKOVSB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgKOVSB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Nov 2020 16:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605475080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDOkYA/y0cIgVh5VedeoQO+onvJns0OacDPTHjXKAU8=;
        b=SHWLAU/wPLGoSVjIUrIqLeDNFgQFvjkL4Y5FyCqFM98J4E5UvNkZD39dvz1ZNE3fPN4JZy
        gshlzVQ7zDuBngWZ8rhrES/+UVMA5Y2rwVNjLXfwESyGsl4fxsHvqsNtLo8lrFQ1Ko2Cu8
        GgmzvZmH16swwd0jYuNH+xVOI6jNzBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-f5mrgqFwO-m6Un9pmOtk-g-1; Sun, 15 Nov 2020 16:17:58 -0500
X-MC-Unique: f5mrgqFwO-m6Un9pmOtk-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90D981084D60;
        Sun, 15 Nov 2020 21:17:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C6D517253;
        Sun, 15 Nov 2020 21:17:54 +0000 (UTC)
Date:   Sun, 15 Nov 2020 22:17:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 04/13 v4] perf tools: Replace aggregation ID with a struct
Message-ID: <20201115211753.GD1081385@krava>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172654.989-5-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 13, 2020 at 07:26:45PM +0200, James Clark wrote:

SNIP

> @@ -754,7 +766,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
>  	FILE *output = config->output;
>  	int nthreads = perf_thread_map__nr(counter->core.threads);
>  	int ncpus = perf_cpu_map__nr(counter->core.cpus);
> -	int thread, sorted_threads, id;
> +	int thread, sorted_threads;
>  	struct perf_aggr_thread_value *buf;
>  
>  	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads, _target);
> @@ -767,13 +779,12 @@ static void print_aggr_thread(struct perf_stat_config *config,
>  		if (prefix)
>  			fprintf(output, "%s", prefix);
>  
> -		id = buf[thread].id;

would it be less changes in here if you kept id with new type?

jirka

>  		if (config->stats)
> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> +			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
>  				 prefix, buf[thread].run, buf[thread].ena, 1.0,
> -				 &config->stats[id]);
> +				 &config->stats[buf[thread].id.id]);
>  		else
> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> +			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
>  				 prefix, buf[thread].run, buf[thread].ena, 1.0,
>  				 &rt_stat);
>  		fputc('\n', output);

SNIP

