Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD4C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952D7223C7
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHUcjLCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKOVRx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgKOVRw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Nov 2020 16:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605475071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2r5BkBuWkH8fItX1cUw3erkZpdXcjkPtzWv+VyqNfJE=;
        b=IHUcjLCXHp3bC5VojM3M39ZBkAISr66yuKPo8uOGZHQl/xDDKWANIESoIwcsN2ULD0KiV8
        sdPq/2VddvbiVbPMzHyYyok1XonbEVYzDEgM4zHC7tXzY2RlqUZSsiYggUocIDtKsxbjGp
        YJWBsuM2b2AFi/qI059gr8aN67QddtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-xfrfzAJGMRWFQ0vo2XSAjQ-1; Sun, 15 Nov 2020 16:17:47 -0500
X-MC-Unique: xfrfzAJGMRWFQ0vo2XSAjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8AE5186840E;
        Sun, 15 Nov 2020 21:17:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CFE427BA5;
        Sun, 15 Nov 2020 21:17:43 +0000 (UTC)
Date:   Sun, 15 Nov 2020 22:17:42 +0100
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
Subject: Re: [PATCH 07/13 v4] perf tools: restrict visibility of functions
Message-ID: <20201115211742.GC1081385@krava>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-8-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172654.989-8-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 13, 2020 at 07:26:48PM +0200, James Clark wrote:
> These cpu_aggr_map refcounting functions are only used in
> builtin-stat.c so their visibilty can be reduced to just
> that file.
> 
> No functional changes.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/builtin-stat.c | 15 +++++++++++++++
>  tools/perf/util/cpumap.c  | 15 ---------------
>  tools/perf/util/cpumap.h  |  2 --
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7daac139f6cc..344e50651b55 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1326,6 +1326,21 @@ static int perf_stat_init_aggr_mode(void)
>  	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
>  }
>  
> +static void cpu_aggr_map__delete(struct cpu_aggr_map *map)
> +{
> +	if (map) {
> +		WARN_ONCE(refcount_read(&map->refcnt) != 0,
> +			  "cpu_aggr_map refcnt unbalanced\n");
> +		free(map);
> +	}
> +}
> +
> +static void cpu_aggr_map__put(struct cpu_aggr_map *map)
> +{
> +	if (map && refcount_dec_and_test(&map->refcnt))
> +		cpu_aggr_map__delete(map);
> +}

you could add them directly as static and skip this change

jirka

> +
>  static void perf_stat__exit_aggr_mode(void)
>  {
>  	cpu_aggr_map__put(stat_config.aggr_map);
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index e831a18ec95e..e90270f0be57 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -112,21 +112,6 @@ struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
>  	return cpus;
>  }
>  
> -void cpu_aggr_map__delete(struct cpu_aggr_map *map)
> -{
> -	if (map) {
> -		WARN_ONCE(refcount_read(&map->refcnt) != 0,
> -			  "cpu_aggr_map refcnt unbalanced\n");
> -		free(map);
> -	}
> -}
> -
> -void cpu_aggr_map__put(struct cpu_aggr_map *map)
> -{
> -	if (map && refcount_dec_and_test(&map->refcnt))
> -		cpu_aggr_map__delete(map);
> -}
> -
>  static int cpu__get_topology_int(int cpu, const char *name, int *value)
>  {
>  	char path[PATH_MAX];
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index d82822ddcbce..b112069038be 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -21,8 +21,6 @@ struct perf_record_cpu_map_data;
>  
>  struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
>  struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
> -void cpu_aggr_map__delete(struct cpu_aggr_map *map);
> -void cpu_aggr_map__put(struct cpu_aggr_map *map);
>  
>  struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
> -- 
> 2.28.0
> 

