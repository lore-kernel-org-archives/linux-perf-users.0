Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3894EC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC460234
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhHaTWB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhHaTV7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:21:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C885604AC;
        Tue, 31 Aug 2021 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437663;
        bh=y8xsBEhjhKK04c0aoOkUN1HQirrD7nQfR2QpWd0Iw1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEtKVnssoyFoVRvb+4oy/vKxBHXxGxsQukxpGJJxJGCJJvCjDWeBYg3VVhivAtb/T
         L/vdns4/PYJv5Y/mTrUZ6FlU9VXyqgre2/XdkkpeLJQJibSepZvhDJ3kOHcpYfc+bc
         s6dlCc7BEsewjC8NaWi0XwZ6VCjnnB39j9/nIgxw+oEGh91Ovh3NsPb+zcsjJ5+3m0
         u6Vnw3eN/u8nWfs/sHGMft9lJqxoI/egEa4ev+Z7udubihP/y8CD3edHeaIwrqu9dp
         8GLV6WSR3gVqcSAJfzraYmXRixrpZb2HbmxVmOexoPPAo2b/WvdoJGLQWlD/7XbaZ6
         2by0hFRJWPpQw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F23B4007E; Tue, 31 Aug 2021 16:21:01 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:21:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/37] perf util: add mmap_cpu_mask__duplicate
 function
Message-ID: <YS6BHW5lbvdPebTS@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <8943a548ef7a3dd3e015095afad7e9a8b2154c05.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8943a548ef7a3dd3e015095afad7e9a8b2154c05.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:10AM +0200, Riccardo Mancini escreveu:
> This patch adds a new function in util/mmap.c to duplicate a mmap_cpu_mask.
> 
> This new function will be used in the following patches.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/mmap.c | 12 ++++++++++++
>  tools/perf/util/mmap.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428b527..9e9a447682cc962c 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -350,3 +350,15 @@ int perf_mmap__push(struct mmap *md, void *to,
>  out:
>  	return rc;
>  }
> +
> +int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
> +				struct mmap_cpu_mask *clone)
> +{
> +	clone->nbits = original->nbits;
> +	clone->bits = bitmap_alloc(original->nbits);
> +	if (!clone->bits)
> +		return -ENOMEM;
> +
> +	memcpy(clone->bits, original->bits, MMAP_CPU_MASK_BYTES(original));
> +	return 0;
> +}
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 9d5f589f02ae70e1..b4923e587fd7749c 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -63,4 +63,7 @@ size_t mmap__mmap_len(struct mmap *map);
>  
>  void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
>  
> +int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
> +				struct mmap_cpu_mask *clone);
> +
>  #endif /*__PERF_MMAP_H */

The jargon here is class__clone():

⬢[acme@toolbox perf]$ find tools/perf -name "*.[ch]" | xargs grep __clone
tools/perf/util/bpf-loader.c:bpf_map_op__clone(struct bpf_map_op *op)
tools/perf/util/bpf-loader.c:bpf_map_priv__clone(struct bpf_map_priv *priv)
tools/perf/util/bpf-loader.c:		newop = bpf_map_op__clone(pos);
tools/perf/util/bpf-loader.c:			priv = bpf_map_priv__clone(tmpl_priv);
tools/perf/util/cgroup.c:			evsel = evsel__clone(pos);
tools/perf/util/evsel.c: * evsel__clone - create a new evsel copied from @orig
tools/perf/util/evsel.c:struct evsel *evsel__clone(struct evsel *orig)
tools/perf/util/evsel.h:	 * Please check evsel__clone() to copy them properly so that
tools/perf/util/evsel.h:struct evsel *evsel__clone(struct evsel *orig);
tools/perf/util/map.h:struct map *map__clone(struct map *map);
tools/perf/util/maps.h:int maps__clone(struct thread *thread, struct maps *parent);
tools/perf/util/parse-events.c:int parse_events_term__clone(struct parse_events_term **new,
tools/perf/util/parse-events.c:		ret = parse_events_term__clone(&n, term);
tools/perf/util/parse-events.h:int parse_events_term__clone(struct parse_events_term **new,
tools/perf/util/symbol.c:				struct map *m = map__clone(new_map);
tools/perf/util/thread.c:static int thread__clone_maps(struct thread *thread, struct thread *parent, bool do_maps_clone)
tools/perf/util/thread.c:	return do_maps_clone ? maps__clone(thread, parent->maps) : 0;
tools/perf/util/thread.c:	return thread__clone_maps(thread, parent, do_maps_clone);
tools/perf/util/map.c:struct map *map__clone(struct map *from)
tools/perf/util/map.c:			struct map *before = map__clone(pos);
tools/perf/util/map.c:			struct map *after = map__clone(pos);
tools/perf/util/map.c:int maps__clone(struct thread *thread, struct maps *parent)
tools/perf/util/map.c:		struct map *new = map__clone(map);
tools/perf/util/pmu.c:		ret = parse_events_term__clone(&cloned, term);
⬢[acme@toolbox perf]$ find tools/perf -name "*.[ch]" | xargs grep __duplicate
⬢[acme@toolbox perf]$
