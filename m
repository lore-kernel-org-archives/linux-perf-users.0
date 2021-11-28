Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9578C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 15:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhK1PeH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 10:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358039AbhK1PcH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 10:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638113330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jS1GKaqtBc1hwwY9M09LSlQCCCVnKythJ8Tx3lCys6Q=;
        b=EPayxP0yLaqB6B6nLR0vT7/mp39bpyaoIj6+or98NcPyEaiSfmiCYe4mdJSvTDNSlxmXUX
        ke/6f9hIkDFQ1rpwZn9zgGFbkGXxuyhkzSN57LcQPGt/SEAXAWb0KomU9DEvYNkal9CmJy
        MbdzWYdVCCraXRcaz4qcfGjWxZ2IML4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-p5UnPJFMPCmaqgwWfxGaOg-1; Sun, 28 Nov 2021 10:28:49 -0500
X-MC-Unique: p5UnPJFMPCmaqgwWfxGaOg-1
Received: by mail-wm1-f69.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so7658650wmj.7
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 07:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jS1GKaqtBc1hwwY9M09LSlQCCCVnKythJ8Tx3lCys6Q=;
        b=D3JylePqim2GCW6fB42NdwjPnrCM7MS8K1ZJWp5tq641sQkVqCy6OoGiMP1YI4QbWQ
         9LFfTS+j+IgrEYSmVdno9W5E4oVrnWVH/XCXkg2/FUH4b995jN2SjyFRh8ekiGMBlxgj
         ehHthEbYxQpw6Ud9XNm5AT7zxc2jl5FBPUsGaqFt+vcEuBE+gutQ0JzPkf2INm4Qb8UZ
         yRTNzUXe8XVPqcFsU8uAx3etS9sKhaTr5orogG3zy7MGeR8lP5wYhxIxHc/PF7M7ayZY
         PCZIE84auw8ZHfHykqGZQSVN9POQVyvqKu06IMyErNqtTBiVt8gamTKzsgYq1MHfUMP3
         6E+A==
X-Gm-Message-State: AOAM532QUs4LEUOKyAjkSU/L8XWWqDj0Qd0iun0KBa+KZKZde7GlLhkX
        KmbvkhDxnW6hOFnOlCJ9xmEVgm6Cr0bXxDyrqjyIcuW8+/1VgpGmwJalM1FoCTlty0o4Ub0ob3t
        53ZN0bm7R//v6pBpaWUCYVtRGRLJt8w==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr29513269wms.81.1638113327918;
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0NMAlM4N7f6386+Iiw5OiDlGOwPV9wnSXFtaTypLOXRUz+t5njxuCSKdoPbRji8TrdAsaeA==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr29513244wms.81.1638113327747;
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f18sm10942751wre.7.2021.11.28.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:28:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Subject: Re: [PATCH v2 1/2] perf evlist: Allow setting arbitrary leader
Message-ID: <YaOgLdMPoGRfMgBX@krava>
References: <20211118220647.2355999-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118220647.2355999-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 18, 2021 at 02:06:46PM -0800, Ian Rogers wrote:
> The leader of a group is the first, but allow it to be an arbitrary
> list member so that for Intel topdown events slots may always be the
> group leader.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

hi,
for both patches:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/evlist.c                  | 15 +++++++++------
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/util/parse-events.c           |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e37dfad31383..974da341b8b0 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
>  	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
>  }
>  
> -void __perf_evlist__set_leader(struct list_head *list)
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
>  {
> -	struct perf_evsel *evsel, *leader;
> +	struct perf_evsel *first, *last, *evsel;
>  
> -	leader = list_entry(list->next, struct perf_evsel, node);
> -	evsel = list_entry(list->prev, struct perf_evsel, node);
> +	first = list_entry(list->next, struct perf_evsel, node);
> +	last = list_entry(list->prev, struct perf_evsel, node);
>  
> -	leader->nr_members = evsel->idx - leader->idx + 1;
> +	leader->nr_members = last->idx - first->idx + 1;
>  
>  	__perf_evlist__for_each_entry(list, evsel)
>  		evsel->leader = leader;
> @@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
>  void perf_evlist__set_leader(struct perf_evlist *evlist)
>  {
>  	if (evlist->nr_entries) {
> +		struct perf_evsel *first = list_entry(evlist->entries.next,
> +						struct perf_evsel, node);
> +
>  		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
> -		__perf_evlist__set_leader(&evlist->entries);
> +		__perf_evlist__set_leader(&evlist->entries, first);
>  	}
>  }
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index f366dbad6a88..6f74269a3ad4 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>  
> -void __perf_evlist__set_leader(struct list_head *list);
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5bfb6f892489..6308ba739d19 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>  		return;
>  
> -	__perf_evlist__set_leader(list);
>  	leader = list_entry(list->next, struct evsel, core.node);
> +	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
>  }
>  
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 

